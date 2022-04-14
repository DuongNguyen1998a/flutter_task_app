import 'package:flutter/material.dart';

class Task {
  String? id;
  String? taskName;
  bool? isCompleted;
  int? priority;
  String? timeStamp;

  Task({this.id, this.taskName, this.isCompleted, this.priority, this.timeStamp});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskName = json['TaskName'];
    isCompleted = json['IsCompleted'];
    priority = json['Priority'];
    timeStamp = json['TimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['TaskName'] = taskName;
    data['IsCompleted'] = isCompleted;
    data['Priority'] = priority;
    data['TimeStamp'] = timeStamp;
    return data;
  }

  String subTitle() {
    String priorityString;

    if (priority == 0) {
      priorityString = 'Low';
    }
    else if (priority == 1) {
      priorityString = 'Medium';
    }
    else {
      priorityString = 'High';
    }

    return '$timeStamp - $priorityString';
  }

  Color itemColor() {
    if (priority == 0) {
      return Colors.green;
    }
    else if (priority == 1) {
      return Colors.amber;
    }
    else {
      return Colors.red;
    }
  }

}
