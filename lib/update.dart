import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/main.dart';


class Update extends StatefulWidget {
  // final dynamic data;
  // const Update(this.data);
  

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {


Future<void> fetchDocumentById(String title,String description) async {
  
  try {
    DocumentReference documentRef = FirebaseFirestore.instance.collection("Note").doc();
    DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

      // Print the current data
      print('Current Data - Document ID: $data, Title: ${data['title']}, Description: ${data['description']}');

      // Update the data
      await documentRef.update({
        "title": "title",
        "description": "description"
      });

      // Fetch the updated data
      DocumentSnapshot updatedSnapshot = await documentRef.get();
      Map<String, dynamic> updatedData = updatedSnapshot.data() as Map<String, dynamic>;

      // Print the updated data
      print('Updated Data - Document ID: $data, Title: ${updatedData['title']}, Description: ${updatedData['description']}');
    } else {
      print('Document not found');
    }
  } catch (e) {
    print('Error fetching/updating document: $e');
  }
}





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
              MaterialPageRoute(builder: (context) =>  Update()),
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
           TextField(
                    controller: _title,
                    decoration: InputDecoration(
                        hintText: ' title',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email)),
                  ),
                  TextField(
                    controller:_description,
                    decoration: InputDecoration(
                        hintText: ' description',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email)),
                  ),
                  ElevatedButton(onPressed: ()async{
                    title=_title.text;
                    description=_description.text;

                    print(title);
                    fetchDocumentById(description,title);



                Navigator.push(
                        context,MaterialPageRoute(builder: (context) =>  Home()
                  )
              
              );
            // CollectionReference Note = FirebaseFirestore.instance.collection('Note');
            //               await Note.add({
            //              'title': title,
            //              "description":description
            //   }
              
              
              _title.clear();
              _description.clear();
                  }, child: Text("Update"))
                 
          

        ],)
      );
  }
}