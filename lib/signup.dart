import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async{
    try{
Response response = await post(
  Uri.parse('https://reqres.in/api/login'),
  body: {
    'email': email,
    'password' : password,
  }
);
 if(response.statusCode == 200){
   var data =jsonDecode(response.body.toString());
   print(data['token']);
   print('Login successfully');
 }else{
   print('Failed');
 }
    }
    catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign up Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Email'
            ),
          ),
         const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: 'Password'
              ),
            ),
            const SizedBox(height: 40),
           GestureDetector(
             onTap: (){
               login(emailController.text.toString(), passwordController.text.toString());
             },
             child: Container(
               height: 50,
               decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
                 color: Colors.green,

               ),
               child: const Center(
                 child: Text('Login'),
               ),
             ),
           ),
          ],
        ),
      ),
    );
  }
}
