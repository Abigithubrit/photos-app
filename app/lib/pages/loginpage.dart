import 'package:app/pages/registerpage.dart';
import 'package:app/pages/screenpage.dart';
import 'package:app/widgets/errordialog.dart';
import 'package:app/widgets/loadingdialog.dart';
import 'package:app/widgets/next.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController email= TextEditingController();
  TextEditingController password= TextEditingController();
  formValidation(){
    if(email.text.isNotEmpty && password.text.isNotEmpty){
      loginNow();
    }
    else {
      showDialog(context: context,
       builder: (c){
        return const ErrorDialog(
          message: 'Please write email password',
        );
       });
    }
  }
  loginNow()async{
     showDialog(context: context,
       builder: (c){
        return const LoadingDialog(
          message: 'Checking credentials',
        );
       });
       User? currentUser;
       await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(), 
        password: password.text.trim()
        ).then((auth){
          currentUser =auth.user!;
        }).catchError((error){
          Navigator.pop(context);
          showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });

        });
        if(currentUser !=null)
        {
          next(context, Screenpage());
        }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height:100,),
              Image.asset('images/a.jpg'),
              TextField(
               controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email'
                ),
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: formValidation,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Login Now'),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account? '),
                  GestureDetector
                  (
                    onTap: () {
                      next(context, Registerpage());
                    },
                    child: Text('Register now',
                    style: TextStyle(color: Colors.red),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}