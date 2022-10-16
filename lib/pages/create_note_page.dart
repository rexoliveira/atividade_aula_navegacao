import 'package:flutter/material.dart';

import '../model/note_model.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicione sua nota"),
      ),
      body: Form(
        key: _formKey,
        onChanged: () {
          setState(() {});
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                }
                return 'Preencha o título';
              },
              decoration: const InputDecoration(
                label: Text('Título'),
              ),
            ),
            TextFormField(
              controller: descriptionController,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                }
                return 'Preencha a descrição';
              },
              minLines: null,
              maxLines: null,
              decoration: const InputDecoration(
                label: Text('Descrição'),
              ),
            ),
            const SizedBox(
              height: 290.0,
            ),
            ElevatedButton(
              onPressed: _formKey.currentState?.validate() == true
                  ? () {
                      final myNote = NoteModel(
                        title: titleController.text,
                        subtitle: descriptionController.text,
                      );

                      Navigator.pop(context, myNote);
                    }
                  : null,
              child: const Text(
                'Criar nota',
              ),
            )
          ],
        ),
      ),
    );
  }
}
