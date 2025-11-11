// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson(data.docId.toString()));

class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final String? image;
  final String? priorityID;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.priorityID,
    this.image,
    this.isCompleted,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    docId: json["docID"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    isCompleted: json["isCompleted"],
    createdAt: json["createdAt"],
    priorityID: json["priorityID"],
  );

  Map<String, dynamic> toJson(String taskID) => {
    "docID": taskID,
    "title": title,
    "description": description,
    "image": image,
    "isCompleted": isCompleted,
    "priorityID": priorityID,
    "createdAt": createdAt,
  };
}
