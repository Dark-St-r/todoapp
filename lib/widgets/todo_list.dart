import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  final List<String> todoList;
  final void Function() updateLocalData;
  const TodoList(
      {super.key, required this.todoList, required this.updateLocalData});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  void onItemClicked(int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.todoList.removeAt(index);
                });
                widget.updateLocalData();
                Navigator.pop(context);
              },
              child: const Text('Mark as Done!'),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.todoList.isEmpty)
        ? const Center(child: Text('List is empty'))
        : ListView.builder(
            itemCount: widget.todoList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.green[300],
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
                  child: const Icon(Icons.check),
                ),
                onDismissed: (direction) {
                  setState(() {
                    widget.todoList.removeAt(index);
                  });
                  widget.updateLocalData();
                },
                child: ListTile(
                  onTap: () {
                    onItemClicked(index);
                  },
                  title: Text(widget.todoList[index]),
                ),
              );
            },
          );
  }
}
