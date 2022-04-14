import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class ApiService {
  static const String baseUrl =
      'https://task-application-2b3a5-default-rtdb.firebaseio.com';

  static var options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  static Dio dio = Dio(options);

  Future<Response> fetchTasks() async {
    try {
      var response = await dio.get('/tasks.json');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addTask(String taskName, int priority, String timeStamp) async {
    try {
      var response = await dio.post('/tasks.json', data: {
        'TaskName': taskName,
        'IsCompleted': false,
        'Priority': priority,
        'TimeStamp': timeStamp
      });
      return response;
    }
    catch (e) {
      rethrow;
    }
  }

  Future<Response> updateTask(
      String id, String taskName, bool isCompleted, int priority, String timeStamp) async {
    try {
      var response = await dio.patch(
        '/tasks.json',
        data: {id: {
          'TaskName': taskName,
          'IsCompleted': isCompleted,
          'Priority': priority,
          'TimeStamp': timeStamp,
        }},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteTask(
      String id) async {
    try {
      var response = await dio.delete(
        '/tasks/$id.json',
      );

      //debugPrint(dio.options.baseUrl);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
