import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

part 'files_event.dart';
part 'files_state.dart';

class FilesBloc extends Bloc<FilesEvent, FilesState> {
  FilesBloc() : super(FilesInitial()) {
    on<SaveFileEvent>(_saveFileIntoStorage);
    on<ReadFileEvent>(_readFileFromStorage);
  }

  FutureOr<void> _readFileFromStorage(ReadFileEvent event, emit) async {
    emit(LoadingState());
    switch (event.storageName) {
      case "tempDirectory":
        var _tempDir = await getTemporaryDirectory();
        var _fileContent = await _readFile(
          event.fileTitle,
          _tempDir,
        );
        emit(ReadFileSuccessState(fileContent: _fileContent));
        break;
      case "appSupportDirectory":
        var _appSuppDir = await getApplicationSupportDirectory();
        var _fileContent = await _readFile(
          event.fileTitle,
          _appSuppDir,
        );
        emit(ReadFileSuccessState(fileContent: _fileContent));
        break;
      case "appDocumentsDirectory":
        var _appDocsDir = await getApplicationDocumentsDirectory();
        var _fileContent = await _readFile(
          event.fileTitle,
          _appDocsDir,
        );
        emit(ReadFileSuccessState(fileContent: _fileContent));
        break;
      case "appLibraryDirectory":
        if (Platform.isIOS) {
          var _libDir = await getLibraryDirectory();
          var _fileContent = await _readFile(
            event.fileTitle,
            _libDir,
          );
          emit(ReadFileSuccessState(fileContent: _fileContent));
        } else {
          emit(ReadFileErrorState(error: "Platform not supported"));
        }
        break;
      case "externalStorageDirectory":
        if (Platform.isAndroid) {
          var _extStDir = await getExternalStorageDirectory();
          var _fileContent = await _readFile(
            event.fileTitle,
            _extStDir!,
          );
          emit(ReadFileSuccessState(fileContent: _fileContent));
        } else {
          emit(ReadFileErrorState(error: "Platform not supported"));
        }
        break;
      default:
        print("No se ha proporcionado directorio");
        break;
    }
  }

  FutureOr<void> _saveFileIntoStorage(SaveFileEvent event, emit) async {
    emit(LoadingState());
    switch (event.storageName) {
      case "tempDirectory":
        var _tempDir = await getTemporaryDirectory();
        try {
          await _saveFile(
            event.fileTitle,
            event.fileContent,
            _tempDir,
          );
          emit(SavedFileSuccessState());
        } catch (e) {
          emit(SavedFileErrorState());
        }
        break;
      case "appSupportDirectory":
        var _appSuppDir = await getApplicationSupportDirectory();
        try {
          await _saveFile(
            event.fileTitle,
            event.fileContent,
            _appSuppDir,
          );
          emit(SavedFileSuccessState());
        } catch (e) {
          emit(SavedFileErrorState());
        }
        break;
      case "appDocumentsDirectory":
        var _appDocsDir = await getApplicationDocumentsDirectory();
        try {
          await _saveFile(
            event.fileTitle,
            event.fileContent,
            _appDocsDir,
          );
          emit(SavedFileSuccessState());
        } catch (e) {
          emit(SavedFileErrorState());
        }
        break;
      case "appLibraryDirectory":
        if (Platform.isIOS) {
          var _libDir = await getLibraryDirectory();
          try {
            await _saveFile(
              event.fileTitle,
              event.fileContent,
              _libDir,
            );
            emit(SavedFileSuccessState());
          } catch (e) {
            emit(SavedFileErrorState());
          }
        }
        break;
      case "externalStorageDirectory":
        if (Platform.isAndroid) {
          try {
            var _extStDir = await getExternalStorageDirectory();
            await _saveFile(
              event.fileTitle,
              event.fileContent,
              _extStDir!,
            );
            emit(SavedFileSuccessState());
          } catch (e) {
            print(e);
            emit(SavedFileErrorState());
          }
        }
        break;
      default:
        print("No se ha proporcionado directorio");
        break;
    }
  }

// TODO: pedir permisos
  Future<void> _saveFile(String _title, String _content, Directory dir) async {
    // referencia al path de la carpeta
    print(dir.path);
    // crear archivo y guardar
    final File file = File('${dir.path}/$_title.txt');
    await file.writeAsString(_content);
  }

  Future<String> _readFile(String _title, Directory dir) async {
    String _content;
    print(dir.path);
    try {
      final File _file = File('${dir.path}/$_title.txt');
      _content = await _file.readAsString();
      return _content;
    } catch (e) {
      print("Couldn't read file");
      return "Not found";
    }
  }
}
