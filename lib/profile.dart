import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var snapshotLocation = FirebaseFirestore.instance.collection("users").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ji"),
      ),
      body:
       Container(
        height: 400,
        child: StreamBuilder<QuerySnapshot>(
          stream: snapshotLocation,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator());
                
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            }
      
            final querySnapshot = snapshot.data!; // Data is guaranteed to be non-null
      
            return ListView.builder(
              itemCount: querySnapshot.size,
              itemBuilder: (context, int index) {
                final document = querySnapshot.docs[index];
      
                return Column(
                  children: [
                    Text(document.get("name")),
                    Text(document.get("email")),
                    Text(document.get("password")),
                  ],
                );
              },
            );
          },
        ),
      ),



      
    );
  }
}