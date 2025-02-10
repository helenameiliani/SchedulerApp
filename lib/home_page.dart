import 'package:flutter/material.dart';
import 'package:scheduller_app/create_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> tasks = [
    {"taskName": "Mathematics", "taskTime": "09.00 - 12.00"},
    {"taskName": "Design", "taskTime": "13.00 - 15.00"},
    {"taskName": "Programming", "taskTime": "16.00 - 18.00"},
    {"taskName": "Research", "taskTime": "19.00 - 21.00"},
    {"taskName": "Presentation", "taskTime": "21.00 - 23.00"},
  ];

  final List<String> ongoingTasks = ["Fitness", "Work"]; // Data Ongoing

  void _addTask(Task task) {
    setState(() {
      ongoingTasks.add(task.name); // Menambahkan task baru ke ongoingTasks
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFA6C61),
      body: Column(
        children: [
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.person_rounded, size: 60, color: Colors.white),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello, User",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text("Have a nice day!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal))
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              child: Container(
                padding: EdgeInsets.only(left: 25, top: 25),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section: Projects
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Projects",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          Text("See more",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemCount: tasks.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(5),
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return ProjectTaskContainer(
                            taskName: task["taskName"] ?? "No Task",
                            taskTime: task["taskTime"] ?? "No Time",
                            icon:
                                Icon(Icons.checklist, color: Color(0xFFFA6C61)),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 25),

                    // Section: Create New Task Button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateTask(
                                      onTaskCreated: _addTask, // Pass callback
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  spreadRadius: 1,
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Create new schedule",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFA6C61))),
                              Icon(Icons.add,
                                  color: Color(0xFFFA6C61), size: 24)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),

                    // Section: Ongoing
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ongoing",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          Text("See more",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    ListView.builder(
                      itemCount: ongoingTasks.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300)),
                          child: Text(
                            ongoingTasks[index],
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFFFA6C61),
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk menampilkan Project Tasks
class ProjectTaskContainer extends StatelessWidget {
  final String taskName;
  final String taskTime;
  final Icon icon;

  const ProjectTaskContainer({
    super.key,
    required this.taskName,
    required this.taskTime,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey.shade600, spreadRadius: 1)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskName,
                style: TextStyle(fontSize: 20, color: Color(0xFFFA6C61))),
            Text(taskTime,
                style: TextStyle(fontSize: 16, color: Color(0xFFFA6C61))),
            SizedBox(height: 15),
            icon
          ],
        ),
      ),
    );
  }
}
