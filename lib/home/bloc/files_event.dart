part of 'files_bloc.dart';

abstract class FilesEvent extends Equatable {
  const FilesEvent();

  @override
  List<Object> get props => [];
}

class SaveFileEvent extends FilesEvent {
  final String storageName;
  final String fileTitle;
  final String fileContent;

  SaveFileEvent({
    required this.storageName,
    required this.fileTitle,
    required this.fileContent,
  });

  @override
  List<Object> get props => [fileTitle, fileContent, storageName];
}

class ReadFileEvent extends FilesEvent {
  final String fileTitle;
  final String storageName;

  ReadFileEvent({
    required this.fileTitle,
    required this.storageName,
  });
  @override
  List<Object> get props => [fileTitle, storageName];
}
