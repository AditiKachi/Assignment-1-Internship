import 'package:flutter/material.dart';
import 'package:smautomation/functions.dart';
import 'package:smautomation/home.dart';
import 'package:smautomation/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(30)),
              const Text("Welcome",
                  style: TextStyle(color: Colors.blue, fontSize: 25.0)),
              const SizedBox(
                height: 50.0,
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
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    child: Field(
                      size,
                      "Enter Password",
                      Icons.lock,
                      true,
                      _password,
                    ),
                  )),
              const SizedBox(
                height: 40.0,
              ),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
                      LoginFunction(_email.text, _password.text).then((user) {
                        if (user != null) {
                          print("Login Sucessfull");
                          ToastMessage("Login successfull");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => HomeScreen()));
                        } else {
                          print("Login Failed");
                          ToastMessage("Field Should not be empty");
                        }
                      });
                    } else {
                      ToastMessage("Please fill correctly");
                      print("Please fill form correctly");
                    }
                  },
                  child: const Text("Login",
                      style: TextStyle(fontSize: 20.0, color: Colors.white))),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RegisterPage())),
                child: const Text(
                  "Not have an account? Create here",
                  style: TextStyle(fontSize: 13.0, color: Colors.blue),
                ),
              )
            ],
          ),
        ));
  }
}

Widget Field(Size size, String hint, IconData icon, bool password,
    TextEditingController controller) {
  return Container(
      alignment: Alignment.center,
      height: size.height / 15,
      width: size.width / 1.3,
      child: TextField(
        controller: controller,
        cursorColor: Colors.blue,
        obscureText: password,
        decoration: InputDecoration(
            focusColor: Colors.blue,
            prefixIcon: Icon(icon),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            )),
      ));
}
