import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/blocs/login-bloc.dart';
import 'package:flutter_application_1/src/firebase/firebase_auth.dart';
import 'package:flutter_application_1/src/resources/dialogs/loading-dialog.dart';
import 'package:flutter_application_1/src/resources/dialogs/msg-dialog.dart';
import 'package:flutter_application_1/src/resources/home-page.dart';
import 'package:flutter_application_1/src/resources/register-page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc = LoginBloc();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FireAuth fireAuth = FireAuth();

  @override
  void dispose() {
    // TODO: implement dispose
    loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Image(image: AssetImage('assets/images/green-car.png')),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  "Welcome back!",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              const Text(
                "Login to continue using iCab",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 10),
                child: StreamBuilder(
                  stream: loginBloc.emailStream, 
                  builder: (context, snapshot) => TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error.toString() : null,
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.orangeAccent)),
                      prefixIcon: const Icon(Icons.email_outlined),
                      labelText: "Email",
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      )
                    ),
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: StreamBuilder(
                  stream: loginBloc.passwordStream,
                  builder: (context, snapshot) => TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error.toString() : null,
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.orangeAccent)),
                      prefixIcon: const Icon(Icons.lock_outline),
                      labelText: "Password",
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      )
                    ),
                  ),
                )
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot password",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.orangeAccent,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      backgroundColor: const MaterialStatePropertyAll<Color>(Colors.orangeAccent),
                    ),
                    onPressed: onLogin,
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: RichText(
                  text: TextSpan(
                    text: "New user? ",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign up for new account",
                        style: const TextStyle(
                          color: Colors.orangeAccent,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.orangeAccent,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = redirectRegister
                      ) 
                    ]
                  )
                  ),
              )
            ],
          ),
        ),
      ), 
    );
  }

  void onLogin() {
    if (loginBloc.isValidInfo(emailController.text, passwordController.text)) {
      LoadingDialog.showLoadingDialog(context, '...Loading');
      fireAuth.signIn(emailController.text, passwordController.text, signInSuccess, signInFailure);
    }
  }

  void signInSuccess() {
    LoadingDialog.hideLoadingDialog(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void signInFailure(msg, title) {
    LoadingDialog.hideLoadingDialog(context);
    MsgDialog.showMsgDialog(context, msg, title);
  }

  void redirectRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }
}
