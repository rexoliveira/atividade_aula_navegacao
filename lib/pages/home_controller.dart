import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../model/note_model.dart';
import '../utils/shared_preferences_keys.dart';
import 'home_state.dart';

class HomeController {
  final VoidCallback onUpdate;
  HomeState state = HomeStateEmpty();

  List<NoteModel> myNotes = <NoteModel>[];

  late final SharedPreferences prefs;

  HomeController({
    required this.onUpdate,
  }) {
    init();
  }

  Future<bool> logout() async {
    return await prefs.clear();
  }

  void updateState(HomeState newState) {
    state = newState;
    onUpdate();
  }

  Future<void> init() async {
    updateState(HomeStateLoading());
    prefs = await SharedPreferences.getInstance();

    final notes = prefs.getString(SharedPreferencesKeys.notes);

    if (notes != null && notes.isNotEmpty) {
      final decoded = jsonDecode(notes);

      final decodedNotes =
          (decoded as List).map((e) => NoteModel.fromJson(e)).toList();

      myNotes.addAll(decodedNotes);

      updateState(HomeStateSuccess());
    } else {
      updateState(HomeStateEmpty());
    }
  }

  Future<void> addNote({required NoteModel note}) async {
    updateState(HomeStateLoading());

    myNotes.add(note);

    final myNotesJson = myNotes.map((e) => e.toJson()).toList();

    prefs.setString(SharedPreferencesKeys.notes, jsonEncode(myNotesJson));

    updateState(HomeStateSuccess());
  }
}
