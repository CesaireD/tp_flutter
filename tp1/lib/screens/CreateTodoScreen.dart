import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tp1/data/models/Todo.dart';
import 'package:tp1/data/services/database.dart';
import 'home_screen.dart';
import '../data/services/todo_service.dart';

class CreateTodoScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CreateTodoScreenState();
  }
  
}
class CreateTodoScreenState extends State<CreateTodoScreen>{
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final deadlineController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  _createTodo(title, description, deadline) async {
    setState(() {
      isLoading = true;
    });
    try {
      final todo = Todo(
        title: title,
        deadlinedAt: deadline,
        description: description,
          createdAt: DateTime.now(),

      );
      var result = await TodoService.create({
        'title': title,
        'description': description,
        'deadlinedAt': deadline
      });

      DatabaseHelper.addNote(todo);
      Fluttertoast.showToast(msg: "Tache créée avec succès");
    } on DioError catch (e) {
      Map<String, dynamic> error = e.response?.data;
      if (error != null && error.containsKey('message')) {
        Fluttertoast.showToast(msg: error['message']);
      } else {
        Fluttertoast.showToast(msg: "Une erreur est survenue veuillez rééssayer");
      }
      print(e.response);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nouvelle Tache"),),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Nouveau Poste", style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.blue),),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Entrez le titre de la tache",
                        labelText: "Titre",
                      ),
                      validator: (value) {
                        return value == null || value == ""
                            ? "Ce champs est obligatoire"
                            : null;
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: contentController,
                      keyboardType: TextInputType.text,
                      minLines: 5,
                      maxLines: 7,
                      decoration: const InputDecoration(
                        hintText: "Entrez la description de la tache",
                        labelText: "description",
                      ),
                      validator: (value) {
                        return value == null || value == ""
                            ? "Ce champs est obligatoire"
                            : null;
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: deadlineController,
                      keyboardType: TextInputType.datetime,
                      minLines: 5,
                      maxLines: 7,
                      decoration: const InputDecoration(
                        hintText: "Entrez la deadline de la tache",
                        labelText: "deadline",
                      ),
                      validator: (value) {
                        return value == null || value == ""
                            ? "Ce champs est obligatoire"
                            : null;
                      },
                    ),
                    SizedBox(height: 20.0,),
                    ElevatedButton(
                        onPressed: () async {
                          if (!isLoading && formKey.currentState!.validate()) {
                            await _createTodo(
                                titleController.text, contentController.text, deadlineController.text);
                            titleController.text = "";
                            contentController.text = "";
                            deadlineController.text = "";
                          }
                        },
                        child: isLoading ? SizedBox(height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 3,)) : Text(
                            "Créer")
                    )
                  ],
                )
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text("Voir la liste des postes",
                  style: TextStyle(fontSize: 17, color: Colors.blue),),
              ),
            )
          ],
        ),
      ),
    );
  }
}