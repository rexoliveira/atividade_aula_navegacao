// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atividade_aula_navegacao/pages/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/note_model.dart';
import '../model/user.dart';
import '../theme/custom_theme.dart';
import '../widget/cusrom_floating_button.dart';
import 'create_note_page.dart';
import 'home_controller.dart';

class NotesPage extends StatefulWidget {
  User? user;
  NotesPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late final HomeController controller;
  @override
  void initState() {
    controller = HomeController(
      onUpdate: () {
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: CustomTheme.black.shade300,
          title: Text("Notas    Olá ${widget.user!.name}!"),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: CustomTheme.black,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Usuário',
              onPressed: () {
                // handle the press
              },
            ),
          ],
        ),
        body: Builder(
          builder: (context) {
            if (controller.state.runtimeType == HomeStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.state.runtimeType == HomeStateEmpty) {
              return const Center(
                child: Text('Você ainda não tem notas!'),
              );
            } else if (controller.state.runtimeType == HomeStateSuccess) {
              return ListView.builder(
                itemCount: controller.myNotes.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.myNotes[i].title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Divider(),
                            Text(
                              controller.myNotes[i].subtitle,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: CustomFloatingButton(onPressed: () async {
          final myNote = await Navigator.push<NoteModel?>(
              context,
              MaterialPageRoute(
                builder: (_) => const CreateNote(),
              ));
          if (myNote != null) {
            controller.addNote(note: myNote);
          }
        }));
  }
}
