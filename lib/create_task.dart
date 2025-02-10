import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Model untuk Task
class Task {
  final String name;
  final String date;
  final String time;

  Task({required this.name, required this.date, required this.time});
}

class CreateTask extends StatefulWidget {
  final Function(Task) onTaskCreated;

  const CreateTask({super.key, required this.onTaskCreated});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  bool _isReminderOn = false;

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final DateFormat _timeFormat = DateFormat('HH:mm');

  @override
  void dispose() {
    _taskNameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = _dateFormat.format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        final now = DateTime.now();
        final formattedTime =
            DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        _timeController.text = _timeFormat.format(formattedTime);
      });
    }
  }

  void _createTask() {
    if (_taskNameController.text.isNotEmpty &&
        _dateController.text.isNotEmpty &&
        _timeController.text.isNotEmpty) {
      final newTask = Task(
        name: _taskNameController.text,
        date: _dateController.text,
        time: _timeController.text,
      );

      widget.onTaskCreated(newTask);

      _taskNameController.clear();
      _dateController.clear();
      _timeController.clear();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success"),
          content: const Text("Create Task Successful"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFA6C61),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFA6C61),
        title: const Text(
          "Create Task",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "image/createtask_image.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                        "Task Name", _taskNameController, false, null),
                    _buildTextField(
                        "Date", _dateController, true, Icons.calendar_today,
                        onTap: () => _selectDate(context)),
                    _buildTextField("Starting Time", _timeController, true,
                        Icons.access_time,
                        onTap: () => _selectTime(context)),
                    _buildReminderSwitch(),
                    const SizedBox(height: 20),
                    _buildCreateButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      bool readOnly, IconData? icon,
      {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: label,
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildReminderSwitch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.notifications, size: 35),
              const SizedBox(width: 10),
              const Text(
                'Remind me',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Switch(
            value: _isReminderOn,
            onChanged: (bool value) {
              setState(() {
                _isReminderOn = value;
              });
            },
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[400],
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: _createTask,
          child: const Text("Create Task",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
