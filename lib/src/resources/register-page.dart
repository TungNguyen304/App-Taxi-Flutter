import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/blocs/register-bloc.dart';
import 'package:flutter_application_1/src/firebase/firebase_auth.dart';
import 'package:flutter_application_1/src/resources/dialogs/loading-dialog.dart';
import 'package:flutter_application_1/src/resources/dialogs/msg-dialog.dart';
import 'package:flutter_application_1/src/resources/home-page.dart';
import 'package:flutter_application_1/src/resources/login-page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RegisterBloc registerBloc = RegisterBloc();
  FireAuth fireAuth = FireAuth();

  @override
  void dispose() {
    // TODO: implement dispose
    registerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Register",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Image(image: AssetImage('assets/images/red-car.png')),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  "Welcome Aboart!",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              const Text(
                "Sign up with iCab is simple steps",
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                  child: StreamBuilder(
                    stream: registerBloc.nameStream,
                    builder: (context, snapshot) => TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.orangeAccent)),
                          prefixIcon: const Icon(Icons.account_circle_outlined),
                          labelText: "Name",
                          labelStyle: const TextStyle(
                            fontSize: 15,
                          )),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: StreamBuilder(
                    stream: registerBloc.phoneStream,
                    builder: (context, snapshot) => TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.orangeAccent)),
                          prefixIcon: const Icon(Icons.phone_callback_outlined),
                          labelText: "Phone Number",
                          labelStyle: const TextStyle(
                            fontSize: 15,
                          )),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: StreamBuilder(
                    stream: registerBloc.emailStream,
                    builder: (context, snapshot) => TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.orangeAccent)),
                          prefixIcon: const Icon(Icons.email_outlined),
                          labelText: "Email",
                          labelStyle: const TextStyle(
                            fontSize: 15,
                          )),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: StreamBuilder(
                    stream: registerBloc.passwordStream,
                    builder: (context, snapshot) => TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.orangeAccent)),
                          prefixIcon: const Icon(Icons.lock_outline),
                          labelText: "Password",
                          labelStyle: const TextStyle(
                            fontSize: 15,
                          )),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll<OutlinedBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      backgroundColor:
                          const MaterialStatePropertyAll<Color>(Colors.orangeAccent),
                    ),
                    onPressed: onRegister,
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: Colors.white),
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
                          text: "Sign in",
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = redirectLogin)
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }

  onRegister() async {
    if(registerBloc.isValidInfo(
      emailController.text,
      passwordController.text,
      nameController.text,
      phoneController.text
    )) {
      LoadingDialog.showLoadingDialog(context, '...Loading');
      fireAuth.signUp(emailController.text, passwordController.text, nameController.text, phoneController.text, registerSuccess, registerFailure);
    }
  }

  void registerSuccess() {
    LoadingDialog.hideLoadingDialog(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void registerFailure(msg, title) {
    LoadingDialog.hideLoadingDialog(context);
    MsgDialog.showMsgDialog(context, msg, title);
  }

  void redirectLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
