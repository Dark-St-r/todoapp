import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class AddTodo extends StatefulWidget {
  final void Function({required String todoText}) addTodo;

  const AddTodo({super.key, required this.addTodo});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Add todo:'),
        TextField(
          onSubmitted: (value) {
            if (_todoText.text.isNotEmpty) {
              widget.addTodo(todoText: _todoText.text);
            }
            _todoText.clear();
          },
          autofocus: true,
          controller: _todoText,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(5.0),
            hintText: 'Write your todo here...',
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (_todoText.text.isNotEmpty) {
                widget.addTodo(todoText: _todoText.text);
              }
              _todoText.clear();
            },
            child: const Text('Add'))
      ],
    );
  }
}
