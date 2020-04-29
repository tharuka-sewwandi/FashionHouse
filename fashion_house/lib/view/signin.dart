import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';
import 'signup.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {

    String _email, _password;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    //new code

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Color(0xFFA1887F)
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft
            ),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,50.0,20.0,10.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/logo.png'),
                    radius: 60.0,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,20.0,20.0,10.0),
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,20.0,20.0,10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 20.0),
                            child: TextFormField(
                              validator: (input){
                                if(input.isEmpty){
                                  return'Please type email';
                                }
                              },
                              onSaved: (input) => _email = input,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 20.0),
                            child: TextFormField(
                              validator: (input){
                                if(input.length<6){
                                  return'Please enter password more than 6 characters';
                                }
                              },
                              onSaved: (input) => _password = input,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              obscureText: true,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0,0.0,10.0,10.0),
                            child: RaisedButton(
                              color: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.red),
                              ),
                              onPressed: signIn,
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,20.0,20.0,10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      SizedBox(width: 10.0,),
                      RaisedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){return SignUp();}));
                        },
                        child: Text('SIGN UP'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

    }


    Future<void> signIn() async{
      final formState = _formKey.currentState;
      if(formState.validate()){
        formState.save();
        try{
          AuthResult result= await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
          //print(result);
          //FirebaseUser user = result.user;
          //await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
        }catch(e){
          print(e.message);
        }
      }
    }
}
