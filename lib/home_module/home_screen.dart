import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controllers
import '../main_controller.dart';
import '../home_module/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();
    final homeController = Get.put(HomeController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          //padding: EdgeInsets.zero,
          children: [
            AppBarWidget(
              widthOfScreen: mainController.widthOfScreen.value,
              homeController: homeController,
            ),
            const Divider(
              color: Colors.grey,
            ),
            TaskListWidget(
              homeController: homeController,
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            Get.dialog(AddTaskWidget(
              homeController: homeController,
            ));
          },
          child: const Icon(Icons.add_outlined),
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class AppBarWidget extends StatelessWidget {
  final double widthOfScreen;
  final HomeController homeController;

  const AppBarWidget({
    Key? key,
    required this.widthOfScreen,
    required this.homeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 10),
      width: widthOfScreen,
      height: AppBar().preferredSize.height + 8,
      //color: Colors.white.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi, Duong',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => Text(
                  '${homeController.numberOfTaskCompleted.value} of ${homeController.tasks.length} task completed',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              homeController.fetchTasks();
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
    );
  }
}

class TaskListWidget extends StatelessWidget {
  final HomeController homeController;

  const TaskListWidget({Key? key, required this.homeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => homeController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: homeController.tasks.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.all(10),
                  child: TaskItemWidget(
                      homeController: homeController, index: index),
                ),
              ),
      ),
    );
  }
}

class TaskItemWidget extends StatelessWidget {
  final HomeController homeController;
  final int index;

  const TaskItemWidget(
      {Key? key, required this.homeController, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        homeController.updateTask(index);
      },
      leading: Container(
        margin: EdgeInsets.zero,
        width: 10,
        height: double.infinity,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: homeController.tasks[index].itemColor()),
      ),
      minLeadingWidth: 15,
      title: Text(
        homeController.tasks[index].taskName ?? '',
        style: TextStyle(
            decoration: homeController.tasks[index].isCompleted ?? true
                ? TextDecoration.lineThrough
                : null),
      ),
      subtitle: Text(homeController.tasks[index].subTitle()),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          homeController.tasks[index].isCompleted ?? true
              ? const Icon(
                  Icons.radio_button_checked_outlined,
                  color: Colors.blue,
                )
              : const Icon(Icons.radio_button_unchecked_outlined),
          IconButton(
            onPressed: () {
              homeController.deleteTask(homeController.tasks[index].id ?? '');
            },
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class AddTaskWidget extends StatelessWidget {
  final HomeController homeController;

  const AddTaskWidget({Key? key, required this.homeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskEditController = TextEditingController();
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Add new task'),
              controller: taskEditController,
            ),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RadioListTile(
                    value: 0,
                    groupValue: homeController.priorityLevel.value,
                    onChanged: (val) {
                      homeController.priorityLevel.value =
                          int.parse(val.toString());
                    },
                    title: const Text('Low'),
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: homeController.priorityLevel.value,
                    onChanged: (val) {
                      homeController.priorityLevel.value =
                          int.parse(val.toString());
                    },
                    title: const Text('Medium'),
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: homeController.priorityLevel.value,
                    onChanged: (val) {
                      homeController.priorityLevel.value =
                          int.parse(val.toString());
                    },
                    title: const Text('High'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            taskEditController.text = '';
            homeController.priorityLevel.value = 0;
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextButton(
          onPressed: () {
            homeController.addTask(taskEditController.text);
            taskEditController.text = '';
            Get.back();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
