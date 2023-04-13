import 'package:app/pages/loginpage.dart';
import 'package:app/pages/screenpage.dart';
import 'package:app/widgets/errordialog.dart';
import 'package:app/widgets/next.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController email = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController password = TextEditingController();
  void register(){
    if(confirmpassword.text.trim() == password.text.trim()){
      authenticate();
    }else{
      showDialog(context: context,
       builder:  (context) => ErrorDialog(
        message: 'password and confirm donot match',
       ),);
    }
  }
  void authenticate() async{
  User? currentUser;
  
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email.text.trim(), 
    password: password.text.trim(),).then((auth){
    currentUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(context: context,
       builder:(c){
        return ErrorDialog(
          message: error.message.toString(),
        );
       });
    });
    if(currentUser !=null){
      saveDataToFireStore(currentUser!).then((value){
        Navigator.pop(context);
        //send user to homepage
        Route newRoute =MaterialPageRoute(builder: (c)=>Screenpage());
        Navigator.pushReplacement(context, newRoute);
      });
    }
    }
    Future saveDataToFireStore(User currentUser)async{
  FirebaseFirestore.instance.collection('admins').doc(currentUser.uid).set({
    'sellerUID':currentUser.uid,
    'Email':currentUser.email,
    'pass':password.text
  
});
    
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
              Image.asset('images/b.jpg',
              fit: BoxFit.cover,
              width: 100,
              height: 100,),
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
              TextField(
                controller: confirmpassword,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm your password',
                  
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: register,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Register Now'),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? '),
                  GestureDetector
                  (
                    onTap: () {
                      next(context, Loginpage());
                    },
                    child: Text('Login now',
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