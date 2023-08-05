// ignore_for_file: prefer_const_constructors

import 'package:amazon_clone_flutter/common/widgets/custom_button.dart';
import 'package:amazon_clone_flutter/common/widgets/custometextfiled.dart';
import 'package:amazon_clone_flutter/constants/globalVariables.dart';
import 'package:amazon_clone_flutter/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth{ signup, signin}

class AuthScreen extends StatefulWidget {
  static const String routeName='/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
 Auth _auth=Auth.signup;
 final _signUpFormKek =GlobalKey<FormState>();
 final _signInFormKek =GlobalKey<FormState>();
 final TextEditingController _emailController=TextEditingController();
 final TextEditingController _passwordController=TextEditingController();
 final TextEditingController _nameController=TextEditingController();
 final AuthService authService=AuthService();

 void signup(){
  authService.signUpUser(
    context: context, 
    name: _nameController.text, 
    email: _emailController.text, 
    password: _passwordController.text);
 }

  void signin(){
  authService.signInUser(
    context: context,
    email: _emailController.text, 
    password: _passwordController.text);
 }

@override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:GlobalVariables.greyBackgroundCOlor,
      body:  SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [
            Text('Welcome',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
            ListTile(
              tileColor: _auth==Auth.signup? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor ,
              title: Text('Create Acount',style: TextStyle(fontWeight: FontWeight.bold),),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value:Auth.signup ,
                groupValue:_auth ,
                onChanged: (Auth? val){
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if(_auth==Auth.signup)
              Container(
                color: GlobalVariables.backgroundColor,
                padding: EdgeInsets.all(8.0),
                child: Form(
                  key: _signUpFormKek,
                  child: Column(children: [
                CustomeTextField(controller: _nameController, hintText: 'Name'),
                SizedBox(height: 10,),
                CustomeTextField(controller: _emailController, hintText: 'Email'),
                SizedBox(height: 10,),
                CustomeTextField(controller: _passwordController, hintText: 'Password'),
                SizedBox(height: 10,),
                CustomeButton(text: 'Sign Up', onTab: (){
                  if(_signUpFormKek.currentState!.validate()){
                    signup();
                  }
                })
              
                ],),
                ),
              ),
            
            ListTile(
                tileColor: _auth==Auth.signin? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor ,
              title: Text('Sign-In',style: TextStyle(fontWeight: FontWeight.bold),),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value:Auth.signin ,
                groupValue:_auth ,
                onChanged: (Auth? val){
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if(_auth==Auth.signin)
              Container(
                color: GlobalVariables.backgroundColor,
                padding: EdgeInsets.all(8.0),
                child: Form(
                  key: _signInFormKek,
                  child: Column(children: [
                CustomeTextField(controller: _emailController, hintText: 'Email'),
                SizedBox(height: 10,),
                CustomeTextField(controller: _passwordController, hintText: 'Password'),
                SizedBox(height: 10,),
                CustomeButton(text: 'Sign In', onTab: (){
                  if(_signInFormKek.currentState!.validate()){
                    signin();
                  }
                })
              
                ],),
                ),
              ),

          ],
          ),
          ),
        ),
      );
    
  }
}