import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/main.dart';


class Update extends StatefulWidget {

  final dynamic title;
    final dynamic description;
        final dynamic id;



  const Update(this.title,this.description,this.id);
  

  @override
  State<Update> createState() => _UpdateState(title,description, id );
}

class _UpdateState extends State<Update> {
        String mytitle;
        String description;
        String id;


  _UpdateState(this.mytitle, this.description,this.id);



 Future<void> fetchDocumentById( mytitle,description) async {
    try {
      DocumentReference documentRef =
          FirebaseFirestore.instance.collection("Note").doc(id);
      DocumentSnapshot documentSnapshot = await documentRef.get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Print the current data
        print(
            'Current Data - Document ID: $id, Title: ${data['title']}, Description: ${data['description']}');

        // Update the data in database
        await documentRef.update({
          "title": mytitle,
          "description": description,
        });

        // Fetch the updated data to show in ui
        DocumentSnapshot updatedSnapshot = await documentRef.get();
        Map<String, dynamic> updatedData =
            updatedSnapshot.data() as Map<String, dynamic>;

        // Print the updated data
        print(
            'Updated Data - Document ID: $id, Title: ${updatedData['title']}, Description: ${updatedData['description']}');
      } else {
        print('Document not found');
      }
    } catch (e) {
      print('Error fetching/updating document: $e');
    }
  }




  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();


    void initState() {
    super.initState();
    _title.text = mytitle; // Set the initial value
    _description.text=description;

    
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text("Update page"),
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
              MaterialPageRoute(builder: (context) =>  Update(mytitle,description,id)),
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
                        hintText: mytitle,


                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email)),
                  ),
                  TextField(
                                            // initialValue:description,

                    controller:_description,
                    decoration: InputDecoration(



                        hintText: description,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email)),
                  ),
                  ElevatedButton(onPressed: ()async{
                    mytitle=_title.text;
                    description=_description.text;

                    // print(title);
                    fetchDocumentById(mytitle,description);



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