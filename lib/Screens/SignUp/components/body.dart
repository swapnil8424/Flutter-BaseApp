import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login/Screens/HomeScreen/home_screen.dart';
import 'package:firebase_login/Screens/Login/login_screen.dart';
import 'package:firebase_login/Screens/SignUp/components/background.dart';
import 'package:firebase_login/Screens/SignUp/components/or_divider.dart';
import 'package:firebase_login/Screens/SignUp/components/social_icon.dart';
import 'package:firebase_login/components/alert_dialog.dart';
import 'package:firebase_login/components/already_have_an_account_check.dart';
import 'package:firebase_login/components/dialog_ok_button.dart';
import 'package:firebase_login/components/rounded_button.dart';
import 'package:firebase_login/components/rounded_input_field.dart';
import 'package:firebase_login/components/rounded_password_field.dart';
import 'package:firebase_login/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _email, _password, _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.03,),
              Text(
                "SIGNUP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.3,
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {},
                onSaved: (input) => _email = input,
              ),
              RoundedPasswordField(
                hintText: "Password",
                onChanged: (value) {},
                onSaved: (input) => _password = input,
              ),
              RoundedPasswordField(
                hintText: "Confirm Password",
                onChanged: (value) {},
                onSaved: (input) => _confirmPassword = input,
              ),
              RoundedButton(
                text: "SIGN UP",
                press: signUp,
              ),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      }
                    ),
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocialIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: googleSignIn,
                  ),
                  SocialIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                ],
              ),
              SizedBox(height: 12,),
            ],
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> _handleSignIn() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    GoogleSignIn _googleSignIn = GoogleSignIn();
    FirebaseUser user;
    bool isSignedIn = await _googleSignIn.isSignedIn();

    if(isSignedIn) {
      user = await _auth.currentUser();
      print("here");
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
      );
      print("there");
      user = (await _auth.signInWithCredential(credential)).user;
      await Firestore.instance.collection('users').document(user.uid).setData({
        'name': user.displayName,
        'image': user.photoUrl,
      });
    }
    print(user);
    return user;
  }

  void googleSignIn() async {
    try{
      FirebaseUser user = await _handleSignIn();
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(user: user,)));
      AlertBox alertBox = new AlertBox(context, "SignUp Successful!", "Google SignIn Successful", [DialogOkButton()]);
      alertBox.showAlertDialog();
    } catch (e) {
      AlertBox alertBox = new AlertBox(context, "Error!", e.message, [DialogOkButton()]);
      alertBox.showAlertDialog();
    }
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try{
        print(_email);
        print(_password);
        if(_password == _confirmPassword) {
          FirebaseAuth auth = FirebaseAuth.instance;
          await auth.createUserWithEmailAndPassword(email: _email, password: _password).then((value) {
            print(value.user.uid);
            Firestore.instance.collection('users').document(value.user.uid).setData({
              'email': _email,
            });
          }).then((value) {
            Widget loginButton = FlatButton(
              child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kPrimaryColor),),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            );
            AlertBox alertBox = new AlertBox(context, "SignUp Successful!", "You have Signed Up Successfully! Login now to explore more!", [loginButton]);
            alertBox.showAlertDialog();
          });
        } else {
          AlertBox alertBox = new AlertBox(context, "Password Error!", "Password fields do not match", [DialogOkButton()]);
          alertBox.showAlertDialog();
        }
      } catch(e) {
        print(e.message);
        AlertBox alertBox = new AlertBox(context, "Error!", e.message, [DialogOkButton()]);
        alertBox.showAlertDialog();
      }
    }
  }
}