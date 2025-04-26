// Import the Flutter Material library, which provides widgets and tools for Material Design.
import 'package:flutter/material.dart';

// Entry point of the Flutter app; runApp starts the app with the ToDoApp widget.
void main() {
  runApp(ToDoApp());
}

// Root widget of the app, defined as a StatelessWidget since it doesn't manage state.
class ToDoApp extends StatelessWidget {
  // Override the build method to describe the UI for this widget.
  @override
  Widget build(BuildContext context) {
    // Return a MaterialApp widget, which sets up the app's structure, theme, and navigation.
    return MaterialApp(
      // Set the app's title, displayed in the device's app switcher.
      title: 'To-Do List App',
      // Define the app's theme using ThemeData, setting the primary color to blue.
      theme: ThemeData(primarySwatch: Colors.blue),
      // Specify the home screen of the app as ToDoHomePage.
      home: ToDoHomePage(),
    );
  }
}

// Home page widget, defined as a StatefulWidget to manage dynamic state (e.g., tasks list).
class ToDoHomePage extends StatefulWidget {
  // Override createState to provide the State object for this widget.
  @override
  _ToDoHomePageState createState() => _ToDoHomePageState();
}

// State class for ToDoHomePage, where state and logic are managed.
class _ToDoHomePageState extends State<ToDoHomePage> {
  // Create a TextEditingController to manage the TextField's input.
  final TextEditingController _controller = TextEditingController();
  // Initialize an empty list to store tasks, where each task is a map with 'title' and 'completed' fields.
  List<Map<String, dynamic>> _tasks = [];

  // Method to add a new task to the list.
  void _addTask() {
    // Check if the TextField input is not empty to avoid adding blank tasks.
    if (_controller.text.isNotEmpty) {
      // Call setState to update the UI after modifying the state.
      setState(() {
        // Add a new task as a map with the input text and initial completed status of false.
        _tasks.add({'title': _controller.text, 'completed': false});
        // Clear the TextField input after adding the task.
        _controller.clear();
      });
    }
  }

  // Method to toggle the completion status of a task at the given index.
  void _toggleTask(int index) {
    // Call setState to update the UI after modifying the state.
    setState(() {
      // Toggle the 'completed' status of the task at the specified index.
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
  }

  // Method to clear all tasks from the list.
  void _clearTasks() {
    // Call setState to update the UI after modifying the state.
    setState(() {
      // Remove all tasks from the _tasks list.
      _tasks.clear();
    });
  }

  // Override the build method to describe the UI for this widget.
  @override
  Widget build(BuildContext context) {
    // Return a Scaffold widget, which provides the basic app structure (app bar, body, etc.).
    return Scaffold(
      // Define the AppBar with a title and an action button.
      appBar: AppBar(
        // Set the title of the AppBar to 'To-Do List'.
        title: Text('To-Do List'),
        // Add a list of action widgets to the AppBar (in this case, an IconButton).
        actions: [
          // Create an IconButton for navigating to the completed tasks page.
          IconButton(
            // Use a check_circle icon to represent completed tasks.
            icon: Icon(Icons.check_circle),
            // Define the action when the button is pressed: navigate to CompletedTasksPage.
            onPressed: () => Navigator.push(
              // Use Navigator to push a new screen onto the navigation stack.
              context,
              // Create a MaterialPageRoute to define the new screen.
              MaterialPageRoute(
                // Specify CompletedTasksPage as the destination, passing the _tasks list.
                builder: (context) => CompletedTasksPage(tasks: _tasks),
              ),
            ),
          ),
        ],
      ),
      // Define the body of the Scaffold, wrapped in a Padding widget for spacing.
      body: Padding(
        // Add 16-pixel padding on all sides for a clean look.
        padding: EdgeInsets.all(16.0),
        // Use a Column to arrange children vertically.
        child: Column(
          // List of child widgets for the Column.
          children: [
            // Create a Row for the input section (TextField and Add button).
            Row(
              // List of child widgets for the Row.
              children: [
                // Use Expanded to make the TextField take available horizontal space.
                Expanded(
                  // Create a TextField for entering tasks.
                  child: TextField(
                    // Assign the TextEditingController to manage input.
                    controller: _controller,
                    // Add decoration for better UX (label and border).
                    decoration: InputDecoration(
                      // Set the label text to guide the user.
                      labelText: 'Enter a task',
                      // Use an outline border for the TextField.
                      border: OutlineInputBorder(),
                    ),
                    // Allow adding a task by pressing the keyboard's submit button.
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                // Add a 10-pixel gap between the TextField and the Add button.
                SizedBox(width: 10),
                // Create an ElevatedButton for adding tasks.
                ElevatedButton(
                  // Call _addTask when the button is pressed.
                  onPressed: _addTask,
                  // Display 'Add' as the button's label.
                  child: Text('Add'),
                ),
              ],
            ),
            // Add a 20-pixel vertical gap after the input section.
            SizedBox(height: 20),
            // Use Align to position the Clear All button to the right.
            Align(
              // Align the child to the center-right of the available space.
              alignment: Alignment.centerRight,
              // Create an ElevatedButton for clearing all tasks.
              child: ElevatedButton(
                // Call _clearTasks when the button is pressed.
                onPressed: _clearTasks,
                // Display 'Clear All' as the button's label.
                child: Text('Clear All'),
                // Customize the button's style with a red background.
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
            // Add a 20-pixel vertical gap before the task list.
            SizedBox(height: 20),
            // Use Expanded to make the ListView take the remaining vertical space.
            Expanded(
              // Check if the task list is empty to show a placeholder or the ListView.
              child: _tasks.isEmpty
                  ? // If empty, show a centered Text widget.
                  Center(child: Text('No tasks yet!'))
                  : // If not empty, show a ListView of tasks.
                  ListView.builder(
                      // Specify the number of items in the ListView.
                      itemCount: _tasks.length,
                      // Define how each item is built.
                      itemBuilder: (context, index) {
                        // Return a Container for styling each task item.
                        return Container(
                          // Add 5-pixel vertical margins for spacing between tasks.
                          margin: EdgeInsets.symmetric(vertical: 5),
                          // Apply decoration for borders and rounded corners.
                          decoration: BoxDecoration(
                            // Add a grey border around the task item.
                            border: Border.all(color: Colors.grey),
                            // Use rounded corners with an 8-pixel radius.
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // Use a ListTile for a clean task item layout.
                          child: ListTile(
                            // Add a Checkbox as the leading widget.
                            leading: Checkbox(
                              // Set the Checkbox value to the task's completed status.
                              value: _tasks[index]['completed'],
                              // Call _toggleTask when the Checkbox is toggled.
                              onChanged: (value) => _toggleTask(index),
                            ),
                            // Display the task title in the ListTile.
                            title: Text(
                              // Get the task's title from the _tasks list.
                              _tasks[index]['title'],
                              // Apply a style based on completion status.
                              style: TextStyle(
                                // Add a strikethrough if the task is completed.
                                decoration: _tasks[index]['completed']
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for the completed tasks page, defined as a StatelessWidget since it doesn't manage state.
class CompletedTasksPage extends StatelessWidget {
  // Property to receive the tasks list from the home page.
  final List<Map<String, dynamic>> tasks;

  // Constructor to initialize the tasks list.
  CompletedTasksPage({required this.tasks});

  // Override the build method to describe the UI for this widget.
  @override
  Widget build(BuildContext context) {
    // Filter the tasks list to include only completed tasks.
    final completedTasks = tasks.where((task) => task['completed']).toList();

    // Return a Scaffold widget for the page structure.
    return Scaffold(
      // Define the AppBar with a title.
      appBar: AppBar(title: Text('Completed Tasks')),
      // Define the body, wrapped in a Padding widget for spacing.
      body: Padding(
        // Add 16-pixel padding on all sides.
        padding: EdgeInsets.all(16.0),
        // Check if there are completed tasks to show a placeholder or a ListView.
        child: completedTasks.isEmpty
            ? // If empty, show a centered Text widget.
            Center(child: Text('No completed tasks!'))
            : // If not empty, show a ListView of completed tasks.
            ListView.builder(
                // Specify the number of items in the ListView.
                itemCount: completedTasks.length,
                // Define how each item is built.
                itemBuilder: (context, index) {
                  // Return a Container for styling each task item.
                  return Container(
                    // Add 5-pixel vertical margins for spacing.
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // Apply decoration for borders and rounded corners.
                    decoration: BoxDecoration(
                      // Add a grey border around the task item.
                      border: Border.all(color: Colors.grey),
                      // Use rounded corners with an 8-pixel radius.
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Use a ListTile to display the task title.
                    child: ListTile(
                      // Display the completed task's title with a strikethrough.
                      title: Text(
                        // Get the task's title from the completedTasks list.
                        completedTasks[index]['title'],
                        // Apply a strikethrough style for completed tasks.
                        style: TextStyle(decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}