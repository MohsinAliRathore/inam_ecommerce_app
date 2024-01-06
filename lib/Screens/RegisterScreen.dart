import 'package:flutter/material.dart';

import '../Widgets/CustomTextField.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 1, 41, 49),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(60, 100, 0, 0),
                  child: Text(
                    "Register Here",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 70, 50, 0),
                  child: CustomTextField(controller: emailController, label: "Name", hint: "Name"),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
                  child: CustomTextField(controller: emailController, label: "Contact No", hint: "03014441469"),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
                  child: CustomTextField(controller: emailController, label: "Email", hint: "mohsin@gmail.com"),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: CustomTextField(controller: passwordController, label: "Password"),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 30, 50, 50),
                    child: ConstrainedBox(
                      constraints:
                      const BoxConstraints(minWidth: double.infinity),
                      child: Container(
                        height: 40.0,
                        child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Color.fromARGB(255, 1, 64, 77)),
                            child: const Text(
                              "Register",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
