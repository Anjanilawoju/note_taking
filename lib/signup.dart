import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
      var snapshotLocation = FirebaseFirestore.instance.collection("users").snapshots();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String name = ""; // Declare the variables here
  String password = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text("SingUp"),

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 500,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: ' Full Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person)),
                    ),
                  ),
                
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: ' Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email)),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.key)),
                          obscureText: true,
                                      ),
                    ),
                  ElevatedButton(
                    onPressed: ()async {
                      // Assign the values to the class-level variables
                      name = _nameController.text;
                      password = _passwordController.text;
                      email = _emailController.text;
                      print("Name: $name");
                      print("Password: $password");
                      print("Email: $email");
                  

                   await FirebaseAuth.instance.createUserWithEmailAndPassword(
                         password:  _passwordController.text,
                         email: _emailController.text,
              );
            
          CollectionReference users = FirebaseFirestore.instance.collection('users');
                          await users.add({
                         'name': name,
                         'password': password,
                         'email': email,
              }
              );
                    },
                    child: Text("SignUp"),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    ) ;
    
  }
}