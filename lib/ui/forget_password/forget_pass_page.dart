import 'package:flutter/material.dart';
import 'package:planeta_uz/ui/forget_password/create_new_pass.dart';
import 'package:planeta_uz/ui/utils/colors.dart';

import '../sign_in/sign_in_page.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});
  final TextEditingController _emmaillcont = TextEditingController();

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
                        'Forgot Password 🤔',
                        style: TextStyle(
                          fontFamily: 'Fjalla',
                          fontSize: MediaQuery.of(context).size.height * 0.032,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
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
                      child: TextFormField(
                        controller: _emmaillcont,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.email),
                            labelText: "Email Address",
                            labelStyle: TextStyle(
                              fontFamily: 'Fjalla',
                            )),
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
                      'We need your email adress so we can send you the password reset code.',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.065,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.01),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.mainButtonColor,
                          ),
                        ),
                        onPressed: (() {
                          if (_emmaillcont.text.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => CreateNewPasswordPage()),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                                content: Text('You should enter email first!!'),
                              ),
                            );
                          }
                        }),
                        child: const Center(
                          child: Text('Sign In'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.49,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Remember the password?',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const SignInPage())),
                              (route) => false),
                          child: Text(
                            'Try again',
                            style: TextStyle(
                                color: AppColors.mainButtonColor,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
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
