import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterdemo/usermanagement.dart';
class SignupPage extends StatefulWidget {
  @override
  _MySignupPageState createState() => new _MySignupPageState();
}
class _MySignupPageState extends State<SignupPage> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:SingleChildScrollView(
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              Container(
                child:Stack(
                  children:<Widget> [
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0,80.0,0.0,0.0),
                      child: Text(
                        'Signup',
                        style:TextStyle(
                          fontSize:80.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0,145.0,0.0,0.0),
                      child: Text(
                        'Here',
                        style:TextStyle(
                          fontSize:80.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(225.0,123.0,0.0,0.0),
                      child: Text(
                        '.',
                        style:TextStyle(
                          fontSize:100.0,
                          color:Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:EdgeInsets.only(top:15.0,left:30.0,right:30.0),
                child:Column(
                  children: <Widget>[
                    TextField(
                      decoration:InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontSize: 22.0,
                            fontFamily:'Montserrat',
                            fontWeight:FontWeight.bold,
                            color:Colors.grey
                        ),
                        focusedBorder:UnderlineInputBorder(
                          borderSide:BorderSide(color:Colors.green),
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          _email=value;
                        });
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextField(
                      decoration:InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            fontFamily:'Montserrat',
                            fontSize: 22.0,
                            fontWeight:FontWeight.bold,
                            color:Colors.grey
                        ),
                        focusedBorder:UnderlineInputBorder(
                          borderSide:BorderSide(color:Colors.green),
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          _password=value;
                        });
                      },
                      obscureText:true,
                    ),
                    SizedBox(height:30.0),
                    Container(
                      height: 40.0,
                      color:Colors.transparent,
                      child:Material(
                        borderRadius:BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color:Colors.green,
                        elevation:3.0,
                        child:GestureDetector(
                          onTap:(){
                            FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: _email,
                                password: _password
                            ).then((signedInUser){
                              UserManagement().storeNewUser(signedInUser,context);
                            })
                                .catchError((e){
                               print(e);
                            });
                          },
                          child:Center(
                            child:Text('SIGNUP',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily:'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:20.0),
                    Container(
                      height: 40.0,
                      child:Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0
                          ),
                          color:Colors.transparent,
                          borderRadius:BorderRadius.circular(20.0),
                        ),
                        child:GestureDetector(
                          onTap:(){
                            Navigator.of(context).pop();
                          },
                          child:Center(
                            child:Text('Go Back',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily:'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height:15.0),
            ]
        ),
      ),
    );
  }
}