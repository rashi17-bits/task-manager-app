import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'login_screen.dart';
 
class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}
 
class _TaskListScreenState extends State<TaskListScreen> {
  List<ParseObject> tasks = [];
 
  @override
  void initState() {
    super.initState();
    fetchTasks();
  }
 
  // Fetch tasks from Back4App
  Future<void> fetchTasks() async {
    final query = QueryBuilder<ParseObject>(ParseObject('Task'))
      ..orderByDescending('createdAt');
    final response = await query.query();
    if (response.success && response.results != null) {
      setState(() {
        tasks = response.results as List<ParseObject>;
      });
    } else {
      _showError(response.error?.message ?? "Failed to fetch tasks");
    }
  }
 
  // Add a new task
  Future<void> addTask(String title, String description) async {
    final task = ParseObject('Task')
      ..set('title', title)
      ..set('description', description);
    final response = await task.save();
    if (response.success) {
      fetchTasks(); // Refresh the task list after adding
    } else {
      _showError(response.error?.message ?? "Failed to add task");
    }
  }
 
  // Edit an existing task
  Future<void> editTask(String objectId, String newTitle, String newDescription) async {
    final task = ParseObject('Task')..objectId = objectId
      ..set('title', newTitle)
      ..set('description', newDescription);
    final response = await task.save();
    if (response.success) {
      fetchTasks(); // Refresh the task list after editing
    } else {
      _showError(response.error?.message ?? "Failed to update task");
    }
  }
 
  // Delete a task and update UI immediately
  Future<void> deleteTask(String objectId) async {
    final task = ParseObject('Task')..objectId = objectId;
    final response = await task.delete();
    if (response.success) {
      setState(() {
        tasks.removeWhere((task) => task.objectId == objectId);
      });
    } else {
      _showError(response.error?.message ?? "Failed to delete task");
    }
  }
 
  // Logout the user
  Future<void> logout() async {
    final user = await ParseUser.currentUser();
    if (user != null) {
      await user.logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
 
  // Show Add Task dialog
  void _showAddTaskDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
 
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              addTask(titleController.text, descriptionController.text);
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
 
  // Show Edit Task dialog
  void _showEditTaskDialog(String objectId, String currentTitle, String currentDescription) {
    TextEditingController titleController = TextEditingController(text: currentTitle);
    TextEditingController descriptionController = TextEditingController(text: currentDescription);
 
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              editTask(objectId, titleController.text, descriptionController.text);
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
 
  // Show error message
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.get<String>('title') ?? ''),
            subtitle: Text(task.get<String>('description') ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showEditTaskDialog(
                    task.objectId!,
                    task.get<String>('title') ?? '',
                    task.get<String>('description') ?? '',
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteTask(task.objectId!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}