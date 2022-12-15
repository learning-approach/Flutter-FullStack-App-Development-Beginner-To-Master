import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_approach/auth/sign_in.dart';
import 'package:learning_approach/bottom_nav_controller.dart';

class SignUp extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  signUp(email, pass,context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      var authCredential = credential.user;
      if (authCredential!.uid.isNotEmpty) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavController()));
      }
      
  
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60,
            left: 25,
            right: 25,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thanks for installing this application!',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'create your account and start your journey with us.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'email address',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'password',
                    prefixIcon: Icon(
                      Icons.remove_red_eye_outlined,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: ()=>signUp(_emailController.text, _passwordController.text, context),
                    child: Text('Sign Up'),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Text.rich(
                  TextSpan(text: 'Already have an account? ', children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SignIn(),
                              ),
                            ),
                      text: 'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
