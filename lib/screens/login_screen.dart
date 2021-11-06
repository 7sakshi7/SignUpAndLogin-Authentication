import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:signup_and_signin/screens/home_screen.dart';
import 'package:signup_and_signin/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // CALLING FIREBASE
  final _auth = FirebaseAuth.instance;

  // login function
  void login(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (uid) => {
              Fluttertoast.showToast(msg: "Login Successful"),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()))
            },
          )
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // email field

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == "") {
          return ("Please Enter Your Email");
        }
        var pattern =
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$";
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(value.toString())) {
          return ("Enter Valid Email");
        } else
          return null;
      },
      onSaved: (value) {
        emailController.text = value.toString();
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );

    // password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        if (value == "") {
          return ("password is required");
        }

        if (!RegExp('(?=.*?[#?!@\$%^&*-])').hasMatch(value.toString())) {
          return ("passwords must have at least one special character");
        } else
          return null;
      },
      onSaved: (value) {
        passwordController.text = value.toString();
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );

    // login Button
    final loginButton = Material(
      elevation: 5.0,
      color: Colors.blueAccent,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
          login(emailController.text, passwordController.text);
        },
        minWidth: MediaQuery.of(context).size.width,
        child: Text(
          'Log In',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        emailField,
                        SizedBox(
                          height: 20.0,
                        ),
                        passwordField,
                        SizedBox(
                          height: 20.0,
                        ),
                        loginButton,
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have an account? "),
                              GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen()));
                                }),
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
