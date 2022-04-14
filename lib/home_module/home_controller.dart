import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_app/home_module/task.dart';
import 'package:task_app/services/api_service.dart';

import '../utils/utils.dart';

class HomeController extends GetxController {
  ApiService service = ApiService();
  var tasks = <Task>[].obs;
  var numberOfTaskCompleted = 0.obs;
  var priorityLevel = 0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchTasks();
    //getNumberOfTaskCompleted();
    super.onInit();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading(true);

      var result = await checkInternetAvailable();

      if (!result) {
        isLoading(false);
        tasks.assignAll([]);
        Get.snackbar('', 'No internet available');
      } else {
        var response = await service.fetchTasks();

        if (response.statusCode == 200) {
          var data = response.data;
          List<Task> mList = [];

          if (data != null) {
            data.forEach((key, value) {
              Task task = Task(
                  id: key,
                  taskName: value['TaskName'],
                  isCompleted: value['IsCompleted'],
                  priority: value['Priority'],
                  timeStamp: value['TimeStamp']);
              mList.add(task);
            });

            tasks.assignAll([]);
            tasks.assignAll(mList);

            getNumberOfTaskCompleted();
          }
        } else {
          tasks.assignAll([]);
        }
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchTasksWithoutLoading() async {
    try {
      var result = await checkInternetAvailable();

      debugPrint(result.toString());

      var response = await service.fetchTasks();

      if (response.statusCode == 200) {
        var data = response.data;
        List<Task> mList = [];

        if (data != null) {
          data.forEach((key, value) {
            Task task = Task(
                id: key,
                taskName: value['TaskName'],
                isCompleted: value['IsCompleted'],
                priority: value['Priority'],
                timeStamp: value['TimeStamp']);
            mList.add(task);
          });

          tasks.assignAll([]);
          tasks.assignAll(mList);

          getNumberOfTaskCompleted();
        } else {
          tasks.assignAll([]);
        }
      } else {
        tasks.assignAll([]);
      }
    } catch (e) {
      rethrow;
    }
  }

  void getNumberOfTaskCompleted() {
    if (tasks.isNotEmpty) {
      numberOfTaskCompleted.value = 0;
      //tasks.map((element) => element.isCompleted ?? false ? debugPrint('Ok') : debugPrint('False')).toList();
      tasks
          .map((element) =>
      element.isCompleted ?? false
          ? numberOfTaskCompleted.value = numberOfTaskCompleted.value + 1
          : numberOfTaskCompleted.value)
          .toList();
    }
  }

  Future<void> updateTask(int index) async {
    try {
      var response = await service.updateTask(
          tasks[index].id ?? '',
          tasks[index].taskName ?? '',
          true,
          tasks[index].priority ?? 0,
          tasks[index].timeStamp ?? '');

      if (response.statusCode == 200) {
        fetchTasksWithoutLoading();
        getNumberOfTaskCompleted();
      } else {
        fetchTasksWithoutLoading();
        getNumberOfTaskCompleted();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTask(String taskName) async {
    try {
      String timeStamp = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

      var response =
      await service.addTask(taskName, priorityLevel.value, timeStamp);

      if (response.statusCode == 200) {
        fetchTasksWithoutLoading();
        getNumberOfTaskCompleted();
      } else {
        fetchTasksWithoutLoading();
        getNumberOfTaskCompleted();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      var response = await service.deleteTask(id);

      if (response.statusCode == 200) {
        fetchTasksWithoutLoading();
        getNumberOfTaskCompleted();
      } else {
        fetchTasksWithoutLoading();
        getNumberOfTaskCompleted();
      }
    } catch (e) {
      rethrow;
    }
  }
}
