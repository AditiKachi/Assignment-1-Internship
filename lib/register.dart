import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smautomation/functions.dart';
import 'package:smautomation/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController _name = TextEditingController();
    final TextEditingController _phone = TextEditingController();
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();
    bool isLoading;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register Page"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30.0,
            ),
            const Text("Create Account",
                style: TextStyle(color: Colors.blue, fontSize: 25.0)),
            const SizedBox(
              height: 50.0,
            ),
            Container(
                alignment: Alignment.center,
                width: size.width,
                child:
                    Field(size, "Enter Name", Icons.account_box, false, _name)),
            const SizedBox(
              height: 23.0,
            ),
            Container(
                alignment: Alignment.center,
                width: size.width,
                child: Field(
                  size,
                  "Enter Phone no",
                  Icons.phone,
                  false,
                  _phone,
                )),
            const SizedBox(
              height: 23.0,
            ),
            Container(
                alignment: Alignment.center,
                width: size.width,
                child: Field(
                  size,
                  "Enter Email",
                  Icons.email,
                  false,
                  _email,
                )),
            const SizedBox(
              height: 23.0,
            ),
            Container(
              alignment: Alignment.center,
              width: size.width,
              child: Field(
                size,
                "Enter Password",
                Icons.lock,
                false,
                _password,
              ),
            ),
            const SizedBox(
              height: 23.0,
            ),
            FlatButton(
                color: Colors.blue,
                onPressed: () {
                  if (_name.text.isNotEmpty &&
                      _email.text.isNotEmpty &&
                      _password.text.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });

                    CreateAccountFun(_name.text, _phone.text, _email.text,
                            _password.text)
                        .then((user) {
                      if (user != null) {
                        setState(() {
                          isLoading = false;
                        });
                        print("Account created successfully");
                        ToastMessage("Account created Successfully");
                      } else if (!_password.text.contains(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')) {
                        print("Password should be at least 6 Characters"
                            "\nPassword must contain special symbols, numbers, alphabets");
                        ToastMessage("Password should be at least 6 Characters"
                            "\nPassword must contain special symbols, numbers, alphabets");
                      } else {
                        print("Account creation failed");
                        ToastMessage("Account Creation Failed");
                      }
                    });
                  } else {
                    ToastMessage("Please Enter Fields");
                    print("Please Enter Fields");
                  }
                },
                child: const Text("Register",
                    style: TextStyle(fontSize: 20.0, color: Colors.white))),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                "Already have an account? Login here",
                style: TextStyle(fontSize: 13.0, color: Colors.blue),
              ),
            )
          ],
        )));
  }
}

void ToastMessage(String message) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 16.0);

String? validatePassword(String value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Enter valid password';
    } else {
      return null;
    }
  }
}
