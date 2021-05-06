import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/loading_widget.dart';

class RegistrationScreen extends StatefulWidget {

  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter you Email'
            )
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                 onChanged: (value) {
                password = value;
              },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter you Password'
                )
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(onPressed: () async {
              setState(() {
                loading = true;
              });
              try {
                final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                if (newUser != null) {
                  Navigator.pushNamed(context, ChatScreen.id);
                }
                setState(() {
                  loading = false;
                });
              }
              catch (e){
                print(e);
              }
            },
                colour: Colors.blueAccent,
                title: 'Register')
          ],
        ),
      ),
    );
  }
}
