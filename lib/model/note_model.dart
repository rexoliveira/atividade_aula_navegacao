import 'dart:convert';

class NoteModel {
  final String title;
  final String subtitle;

  NoteModel({
    required this.title,
    required this.subtitle,
  });

  NoteModel copyWith({
    String? title,
    String? subtitle,
  }) {
    return NoteModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source));

  @override
  String toString() => 'NoteModel(title: $title, subtitle: $subtitle)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteModel &&
        other.title == title &&
        other.subtitle == subtitle;
  }

  @override
  int get hashCode => title.hashCode ^ subtitle.hashCode;
}
