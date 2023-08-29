import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_taking/main.dart';


class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
    String title="";
    String description="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text("Add Note"),
      ),
      
        
      bottomNavigationBar: BottomNavigationBar(
        items:  const [


BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),

        BottomNavigationBarItem(icon: Icon(Icons.add),label: "add",
        

        
        
        ),


        ],



        
           onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNote()),
            );
          }
if (index == 0) {
  
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Home()),
            );
          }

        }
        ,
        
        ),
        body:Column(children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
                      controller: _title,
                      decoration: InputDecoration(
                          hintText: ' title',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email)),
                    ),
           ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller:_description,
                      decoration: InputDecoration(
                          hintText: ' description',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email)),
                    ),
                  ),
                  ElevatedButton(onPressed: ()async{
                    title=_title.text;
                    description=_description.text;

                    print(title);
                    if(title.isEmpty || description.isEmpty){
                      const snackBar = SnackBar(
  content: Text('Add title and description'),
);
ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
           else{
             CollectionReference Note = FirebaseFirestore.instance.collection('Note');
                          await Note.add({
                         'title': title,
                         "description":description
              }
              
              );
              _title.clear();
              _description.clear();

               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Home()),
              );
           }
                  }, child: Text("AddNote"))
                 
          

        ],)
      );
  }
}