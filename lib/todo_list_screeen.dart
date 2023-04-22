import 'package:flutter/material.dart';
import 'package:todo_list/todo_model.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoModel> todoList = [];

  @override
  void initState() {
    super.initState();
    //TodoModel,set mouse focus target, with Ctrol+D -> copy
    todoList.add(TodoModel("helth", false));
    todoList.add(TodoModel("cook", true));
    todoList.add(TodoModel("jooging", true));
    todoList.add(TodoModel("study", false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
        actions: [
          IconButton(
              onPressed: () {
                //call popup
                _dailog();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: _listView(),
    );
  }

  Widget _listView() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return _listTile(todoList[index], index);
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey,
        );
      },
      itemCount: todoList.length,
    );
  }

  Widget _listTile(TodoModel todoModel, int index) {
    TextStyle textStyle = TextStyle(fontSize: 18);
    if (todoModel.complete) {
      textStyle = const TextStyle(
          fontSize: 18,
          decorationStyle: TextDecorationStyle.solid,
          decorationThickness: 3,
          decoration: TextDecoration.lineThrough,
          decorationColor: Colors.red);
    }

    return ListTile(
      title: Text(todoModel.text, style: textStyle),
      leading: _checkbox(todoModel),
      trailing: _delete(index),
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      minVerticalPadding: 20,
      horizontalTitleGap: 16,
    );
  }

  Widget _checkbox(TodoModel todoModel) {
    return Transform.scale(
      scale: 1.5,
      child: Checkbox(
        value: todoModel.complete,
        onChanged: (value) {
          //when checkbox click,
          //print('value: $value');
          setState(() {
            todoModel.complete = !todoModel.complete;
          });
        },
        overlayColor: MaterialStatePropertyAll(Colors.green.shade300),
        splashRadius: 26,
        fillColor: MaterialStatePropertyAll(Colors.deepPurple),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _delete(int index) {
    return IconButton(
        onPressed: () {
          setState(() {
            todoList.removeAt(index);
          });
        },
        icon: Icon(Icons.delete));
  }

  void _dailog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text('Todo-list add'));
        });
  }
}
