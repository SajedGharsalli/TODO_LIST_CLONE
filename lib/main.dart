import 'package:flutter/material.dart';
import 'task_class.dart';

void main(){runApp(const MaterialApp(home: Home(),));}

//StatefulWidget to fast reload any changes

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Task> tasks=[]; // list where I store tasks
  List<TextEditingController> controllers=[]; //list to add different textField for each task

  @override
  void dispose(){
    for (var c in controllers){c.dispose();} //dispose every element in controllers
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[400],
      appBar: AppBar(
        title:const Text('TO-DO LIST',style: TextStyle(fontSize: 23,letterSpacing: 1.5),),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 0,
        actions: [
          ElevatedButton.icon(onPressed: (){
            setState(() {
              tasks.add(Task(text: '',state: false)); //add an element to the task list on each press
            });
          },
            icon: const Icon(Icons.add_box,size: 30,),
            label: const Text('ADD TASK',style: TextStyle(fontSize: 20),),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, i){
          Task task=tasks[i];
          TextEditingController textEditingController;
          if (i >=controllers.length){textEditingController= TextEditingController();controllers.add(textEditingController);}
          else {textEditingController=controllers[i];}
          return Container(
            padding:const EdgeInsets.all(10),
            margin:const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Checkbox(value: task.state, onChanged: (bool? value){setState(() {task.state=value!;});}),
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    onChanged: (value){
                      setState(() {
                        task.text=value;
                      });
                    },
                    decoration:const InputDecoration(hintText: 'NEW TASK',hintStyle: TextStyle(fontSize: 24),),
                    style:const TextStyle(fontSize: 24,letterSpacing: 1,fontWeight: FontWeight.bold,),
                  ),
                ),
                IconButton(onPressed:(){setState(() {tasks.remove(task);controllers.remove(textEditingController);});} ,
                    icon:const Icon(Icons.delete,color: Colors.black87,size: 40,),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}