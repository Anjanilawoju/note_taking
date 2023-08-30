import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_taking/addnote.dart';
import 'package:note_taking/login.dart';
import 'package:note_taking/update.dart';

//main function
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
    await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAfMDzZhuQ64KLUm6aLyKCXekbaejQQuk0",
      appId: "1:469961258680:android:3a3c3fb7b5859acd0da64d",
      messagingSenderId: "469961258680	",
      projectId: "note-4935f",
  )
  );

final auth=FirebaseAuth.instance.currentUser;
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,

    home: auth!=null?Home():login(),
  ));
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _subject = TextEditingController();
  final _description = TextEditingController();
  // data location reference
  var snapshotLocation =
      FirebaseFirestore.instance.collection("Note").snapshots();
  //featch and update

  String id = "";

  // String mytitle="";
  // String description="";

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

  bool v1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
      ),
      drawer: Drawer(
        child: Column(children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Color.fromARGB(255, 141, 113, 113),
            child: const Column(children: [
              CircleAvatar(
                  radius: 70,
                  child:Icon(Icons.person)),
              Text("Anjali"),
              Text("anjali@gmail.com")
            ]),
          ),
      

          ListTile(
            leading: Icon(Icons.logout),
            title: Text("logout"),
            onTap: (
              () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                          return login();
                                       }), 
                                       
                                       (route) => false);
              })
              
              ),


          
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ]
        
        ),
      ),

      // Body

      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 231, 227, 227),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1504677706860-f93ba524daf8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Zm91bmR8ZW58MHx8MHx8fDA%3D&w=1000&q=80"))),
        child: SingleChildScrollView(
          child: Center(
            child: v1
                ? Center(
                    child: Container(
                      height: 475,
                      // width: 400,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Center(
                        child: Column(
                          children: [

                            //input title
                            Container(
                              height: 100,
                              width: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: TextField(
                                  controller: _subject,
                                  decoration: InputDecoration(
                                      hintText: "Title",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                ),
                              ),
                            ),

// input description
                            Container(
                              height: 100,
                              width: 500,
                              child: TextField(
                                controller: _description,
                                decoration: InputDecoration(
                                    hintText: "description",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {

                                     String  mytitle = _subject.text;
                                       String description = _description.text;


                                      print(mytitle);
                                      fetchDocumentById(mytitle,description);

                                      //update

                                      v1 = false;
                                    });
                                  },
                                  child: Text("Update")),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  
                : Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: snapshotLocation,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData) {
                            return Center(child: Text('No data available'));
                          }

                          final querySnapshot = snapshot
                              .data!; // Data is guaranteed to be non-null

                          return Container(
                            // height: double.infinity,
                            height: 500,


                      // read 
                            child: ListView.builder(
                              itemCount: querySnapshot.size,
                              itemBuilder: (context, int index) {
                                final document = querySnapshot.docs[index];
                                var title = document.get("title");
                                var description = document.get("description");

                                return Column(
                                  children: [
                                    Card(
                                      elevation: 100,
                                      shadowColor: Colors.black,
                                      child: Container(
                                        width: 400,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text("Title:" +
                                                  document.get("title")),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Text("Description:" +
                                                  document.get("description")),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {

                                                          String title=document.get("title");
                                                          String description=document.get("description");
                                                          String id=document.id;


                                                          // fetchDocumentById(title,description);
                                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  Update(title,description,id)),  );

                                                      

                                                          id = document.id;
                                                          v1 = true;
                                                        });
                                                      },
                                                      child: Text("Edit")),
                                                ),

                                                
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                      onPressed: () async {
                                                        DocumentReference
                                                            documentRef =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Note")
                                                                .doc(document
                                                                    .id);
                                                        await documentRef
                                                            .delete();
                                                      },
                                                      child: Text("Delete")),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "add",
            ),
          ],
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddNote()),
              );
            }
          }),
    );
  }
}