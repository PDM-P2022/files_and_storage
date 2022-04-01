import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bloc/files_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  var _titleC = TextEditingController();
  var _contentC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: BlocConsumer<FilesBloc, FilesState>(
        listener: (context, state) {
          if (state is SavedFileSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Se ha guardado correctamente..")),
            );
            _contentC.clear();
          } else if (state is SavedFileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Ha ocurrido un error al guardar..")),
            );
            _titleC.clear();
          } else if (state is ReadFileSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Cargando contenido..")),
            );
            _contentC.text = state.fileContent;
          } else if (state is ReadFileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text("Error al leer archivo: ${state.error}..")),
            );
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                leading: IconButton(
                  tooltip: "Guardar archivo",
                  icon: Icon(FontAwesomeIcons.fileSignature),
                  onPressed: () {
                    BlocProvider.of<FilesBloc>(context).add(
                      SaveFileEvent(
                        fileTitle: _titleC.text,
                        fileContent: _contentC.text,
                        storageName: "tempDirectory",
                      ),
                    );
                  },
                ),
                title: Text("tempDirectory"),
                subtitle: Text("/data/user/0/com.app.package/cache"),
                trailing: IconButton(
                  tooltip: "Leer archivo",
                  icon: Icon(FontAwesomeIcons.readme),
                  onPressed: () {
                    BlocProvider.of<FilesBloc>(context).add(
                      ReadFileEvent(
                        fileTitle: _titleC.text,
                        storageName: "tempDirectory",
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                leading: IconButton(
                  tooltip: "Guardar archivo",
                  icon: Icon(FontAwesomeIcons.fileSignature),
                  onPressed: () {
                    BlocProvider.of<FilesBloc>(context).add(
                      SaveFileEvent(
                        fileTitle: _titleC.text,
                        fileContent: _contentC.text,
                        storageName: "appSupportDirectory",
                      ),
                    );
                  },
                ),
                title: Text("appSupportDirectory"),
                subtitle: Text("/data/user/0/com.app.package/files"),
                trailing: IconButton(
                  tooltip: "Leer archivo",
                  icon: Icon(FontAwesomeIcons.readme),
                  onPressed: () {
                    BlocProvider.of<FilesBloc>(context).add(
                      ReadFileEvent(
                        fileTitle: _titleC.text,
                        storageName: "appSupportDirectory",
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                leading: IconButton(
                  tooltip: "Guardar archivo",
                  icon: Icon(FontAwesomeIcons.fileSignature),
                  onPressed: () {
                    BlocProvider.of<FilesBloc>(context).add(
                      SaveFileEvent(
                        fileTitle: _titleC.text,
                        fileContent: _contentC.text,
                        storageName: "appDocumentsDirectory",
                      ),
                    );
                  },
                ),
                title: Text("appDocumentsDirectory"),
                subtitle: Text("/data/user/0/com.app.package/app_flutter"),
                trailing: IconButton(
                  tooltip: "Leer archivo",
                  icon: Icon(FontAwesomeIcons.readme),
                  onPressed: () {
                    BlocProvider.of<FilesBloc>(context).add(
                      ReadFileEvent(
                        fileTitle: _titleC.text,
                        storageName: "appDocumentsDirectory",
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              ListTile(
                leading: IconButton(
                  tooltip: "Guardar archivo",
                  icon: Icon(FontAwesomeIcons.fileSignature),
                  onPressed: () {
                    BlocProvider.of<FilesBloc>(context).add(
                      SaveFileEvent(
                        fileTitle: _titleC.text,
                        fileContent: _contentC.text,
                        storageName: "appLibraryDirectory",
                      ),
                    );
                  },
                ),
                title: Text("appLibraryDirectory"),
                subtitle: Text("iOS y Mac"),
                trailing: IconButton(
                  tooltip: "Leer archivo",
                  icon: Icon(FontAwesomeIcons.readme),
                  onPressed: () {
                    BlocProvider.of<FilesBloc>(context).add(
                      ReadFileEvent(
                        fileTitle: _titleC.text,
                        storageName: "appLibraryDirectory",
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                leading: IconButton(
                  tooltip: "Guardar archivo",
                  icon: Icon(FontAwesomeIcons.fileSignature),
                  onPressed: () {
                    BlocProvider.of<FilesBloc>(context).add(
                      SaveFileEvent(
                        fileTitle: _titleC.text,
                        fileContent: _contentC.text,
                        storageName: "externalStorageDirectory",
                      ),
                    );
                  },
                ),
                title: Text("externalStorageDirectory"),
                subtitle: Text(
                    "/storage/emulated/0/Android/data/com.app.package/files"),
                trailing: IconButton(
                  tooltip: "Leer archivo",
                  icon: Icon(FontAwesomeIcons.readme),
                  onPressed: () {
                    BlocProvider.of<FilesBloc>(context).add(
                      ReadFileEvent(
                        fileTitle: _titleC.text,
                        storageName: "externalStorageDirectory",
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(18),
                child: TextField(
                  controller: _titleC,
                  decoration: InputDecoration(
                    label: Text("Titulo del archivo"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: TextField(
                  controller: _contentC,
                  maxLines: 2,
                  maxLength: 100,
                  decoration: InputDecoration(
                    label: Text("Contenido del archivo"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
