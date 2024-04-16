import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/widgets/add_todo.dart';
import 'package:todoapp/widgets/todo_list.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> todoList = [];

  void addTodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Already exists'),
              content: const Text('This todo data already exists.'),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close')),
              ],
            );
          });

      return;
    }

    setState(() {
      todoList.insert(0, todoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todoList', todoList);
  }

  void getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList = (prefs.getStringList('todoList') ?? []).toList();
    });
  }

  void onPlusButtonClicked(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              height: 200,
              child: AddTodo(addTodo: addTodo),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.blueGrey[900],
        onPressed: () => onPlusButtonClicked(context),
        child: const Icon(FeatherIcons.plus, color: Colors.white),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey[900],
              height: 200,
              width: double.infinity,
              child: const Center(
                child: Text(
                  'Todo App',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse('https://github.com/Dark-St-r'));
              },
              leading: const Icon(FeatherIcons.user),
              title: const Text(
                'About Me',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(
                    Uri.parse('mailto:someone@example.com?subject=Hello'));
              },
              leading: const Icon(FeatherIcons.mail),
              title: const Text(
                'Contact Me',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo App'),
      ),
      body: TodoList(todoList: todoList, updateLocalData: updateLocalData),
    );
  }
}
