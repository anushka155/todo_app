import 'dart:convert';

class Todo {
  final int? id;
  final String? desc;
  final String title;
  final String description;
  final String isChecked;

  const Todo({
    this.id,
    required this.desc,
    required this.title,
    required this.description,
    required this.isChecked,
  });

  Todo copyWith({
    int? id,
    String? desc,
    String? title,
    String? description,
    String? isChecked,
  }) {
    return Todo(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      title: title ?? this.title,
      description: description ?? this.description,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'desc': desc,
      'title': title,
      'description': description,
      'isChecked': isChecked,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      desc: map['desc'],
      title: map['title'],
      description: map['description'],
      isChecked: map['isChecked'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Todo(id: $id, desc: $desc, title: $title, description: $description, isChecked: $isChecked)';
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.desc == desc &&
        other.title == title &&
        other.description == description &&
        other.isChecked == isChecked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        desc.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isChecked.hashCode;
  }
}
