// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Todo> postFromJson(String str) => List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

class Todo {
  Todo({
    this.id,
    this.description,
    required this.title,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.beginedAt,
    required this.deadlinedAt,
    this.finishedAt
  });

  String? id;
  String? description;
  String? title;
  String? userId;
  DateTime? createdAt;
  DateTime? beginedAt;
  DateTime? deadlinedAt;
  DateTime? updatedAt;
  DateTime? finishedAt;
  User? user;

  Map<String,dynamic> toJson() => {
    'id' : id,
    'title' : title,
    'userId' : userId,
    'description' : description,
    'createdAt' : createdAt,
    'beginedAt' : beginedAt,
    'deadlinedAt' : deadlinedAt,
    'updatedAt' : updatedAt,
    'finishedAt' : finishedAt,

  };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json["id"] == null ? null : json["id"],
    description: json["description"] == null ? null : json["description"],
    title: json["title"] == null ? null : json["title"],
    userId: json["user_id"] == null ? null : json["user_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    beginedAt: json["begined_at"] == null ? null : DateTime.parse(json["begined_at"]),
    finishedAt: json["finished_at"] == null ? null : DateTime.parse(json["finished_at"]),
    deadlinedAt: json["deadlined_at"] == null ? null : DateTime.parse(json["deadlined_at"]),
  );

}

class User {
  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.username,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? email;
  String? username;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    email: json["email"] == null ? null : json["email"],
    username: json["username"] == null ? null : json["username"],
  );
}