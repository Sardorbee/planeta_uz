import 'package:flutter/material.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:planeta_uz/ui/forget_password/forget_pass_page.dart';
import 'package:planeta_uz/ui/sign_up/sign_up_page.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    // AuthProvider x = context.watch<AuthProvider>();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 240, 240),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: h * 0.6,
                child: stackmethod(context),
              ),
              SizedBox(
                height: h * 0.06,
              ),
              Column(
                children: [
                  const Center(
                    child: Text('or continue with'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: w * 0.2, right: w * 0.2, top: w * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          maxRadius: h * 0.045,
                          child: Icon(Icons.facebook_sharp, size: w * 0.1),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          maxRadius: h * 0.045,
                          child: Text(
                            'G',
                            style: TextStyle(
                                fontSize: w * 0.1, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(w * 0.18),
                    child: Row(
                      children: [
                        const Text("Don't have an account yet? "),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const SignUpPage()),
                              ),
                            );
                          },
                          child: const Text(
                            'Registration',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Stack stackmethod(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    AuthProvider x = context.watch<AuthProvider>();
    var h = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(37, 43, 51, 1),
              borderRadius: BorderRadius.circular(h * 0.025),
            ),
            width: w * 1,
            height: h * 0.4,
          ),
        ),
        Positioned(
          right: w * 0.65,
          top: h * 0.15,
          child: Text(
            'Sign In',
            style: TextStyle(color: Colors.white, fontSize: w * 0.08),
          ),
        ),
        Positioned(
          top: h * 0.22,
          left: w * 0.05,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(h * 0.023),
            ),
            width: w * 0.9,
            height: h * 0.36,
            child: Container(
              padding: EdgeInsets.all(h * 0.02),
              child: Column(
                children: [
                  TextFormField(
                    controller: x.emailController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.check_circle_rounded),
                      labelText: 'Email',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  TextFormField(
                    obscureText: x.obscureText,
                    controller: x.passwordController,
                    decoration: InputDecoration(
                      labelText: ('Password'),
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple.shade600),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(x.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            x.obscureText = !x.obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: h * 0.012),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ForgetPasswordPage()))),
                    hoverColor: Colors.blue,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Do not remember the password?',
                        style: TextStyle(color: Colors.blue.shade900),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: h * 0.045),
                  ),
                  SizedBox(
                    height: h * 0.06,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(h * 0.031),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(37, 43, 51, 1),
                        ),
                      ),
                      onPressed: (() {
                        // if (_passwordcontroller.text == '123456' &&
                        //     _emailcontroller.text == '123@gmail.com') {
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: ((context) => const HomePage())),
                        //     (route) => false);

                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //         content: Text('Email or Password is incorrect'),
                        //         backgroundColor: Colors.red,
                        //         duration: Duration(seconds: 1)),
                        // );
                        // }
                      }),
                      child: const Center(
                        child: Text('Sign In'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
