import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_taking/main.dart';
import 'package:note_taking/signup.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _emailController=TextEditingController();
    final _passwordController=TextEditingController();
// String password="";
// String email="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text("Login"),
      ),

      body: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

                      print("Login");
                      // Assign the values to the class-level variables
                     String password = _passwordController.text;
                     String email = _emailController.text;
                      print("Password: $password");
                      print("Email: $email");
                  
              
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                         password: password,
                         email: email,
              );
                                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                        return Home();
                                       }), (route) => false);
                    },
                    child: Text("Login"),
                  ),
                  SizedBox(height:10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Don't have an account?"),

                  InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return SignUp();
                    }));
                  }, child: Text("Create an account", style:TextStyle(color: Colors.blue)
                  ))
                ],)




        ],
      ),
    );
  }
}