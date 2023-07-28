import 'package:flutter/material.dart';

class CreateNewPasswordPage extends StatelessWidget {
   CreateNewPasswordPage({super.key});
final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Scaffold(
        // appBar: AppBar(backgroundColor: Colors.transparent),
        backgroundColor: const Color.fromARGB(255, 243, 240, 240),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.height * 0.02),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Create New Password 🔒',
                        style: TextStyle(
                          fontFamily: 'Fjalla',
                          fontSize: MediaQuery.of(context).size.height * 0.032,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontFamily: 'Fjalla'),
                      'You can create a new password, please dont forget it too.',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * 0.019),
                        color: Colors.black12,
                      ),
                      child: TextFormField(focusNode: _focusNode,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.lock),
                            labelText: "New Password",
                            labelStyle: TextStyle(
                              fontFamily: 'Fjalla',
                            )),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * 0.019),
                        color: Colors.black12,
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Repeat New Password",
                            labelStyle: TextStyle(
                              fontFamily: 'Fjalla',
                            )),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.065,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.028),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(37, 43, 51, 1),
                          ),
                        ),
                        onPressed: (() {}),
                        child: const Center(
                          child: Text('Sign In'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.41,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive an email?",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                        InkWell(
                          child: Text(
                            'Send again',
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
