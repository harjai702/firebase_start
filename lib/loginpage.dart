import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'usermanagement.dart';
class LoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => new _MyLoginPageState();
}
class _MyLoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    return new Scaffold(
        body:SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              Container(
                child:Stack(
                  children:<Widget> [
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0,90.0,0.0,0.0),
                      child: Text(
                        'Hello',
                        style:TextStyle(
                          fontSize:80.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0,155.0,0.0,0.0),
                      child: Text(
                        'There',
                        style:TextStyle(
                          fontSize:80.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(225.0,133.0,0.0,0.0),
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
                padding:EdgeInsets.only(top:20.0,left:30.0,right:30.0),
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
                    Container(
                      alignment:Alignment(1.0,0.0),
                      padding:EdgeInsets.only(top:15.0,left:20.0),
                      child:InkWell(
                          child:Text('Forget Password',
                            style:TextStyle(
                                color:Colors.green,
                                fontWeight:FontWeight.bold,
                                fontFamily:'Montserrat',
                                decoration: TextDecoration.underline
                            ),
                          )
                      ),
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
                            FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)
                                .then((FutureOr user){
                                  Navigator.of(context).pushReplacementNamed('/homepage');
                            })
                                .catchError((e){
                                  print(e);
                            });
                          },
                          child:Center(
                            child:Text('LOGIN',
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
                          onTap:(){},
                          child:Center(
                            child:Text('Login with Facebook',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'New to Rockit ?',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child:Text('Register',
                      style:TextStyle(
                        color:Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration:TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}