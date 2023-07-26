import 'package:flutter/material.dart';
import 'package:planeta_uz/ui/sign_in/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool obscureText = true;
  bool obscureText1 = true;

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
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Text(
                        'Registration',
                        style: TextStyle(
                          fontFamily: 'Fjalla',
                          fontSize: MediaQuery.of(context).size.height * 0.032,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontFamily: 'Fjalla'),
                        '',
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
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: "Username",
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * 0.019),
                          color: Colors.black12,
                        ),
                        child: TextFormField(
                          obscureText: obscureText,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.lock),
                              labelText: "Password",
                              suffixIcon: IconButton(
                                icon: Icon(obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                              ),
                              labelStyle: const TextStyle(
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
                          obscureText: obscureText1,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(obscureText1
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    obscureText1 = !obscureText1;
                                  });
                                },
                              ),
                              labelText: "Repeat Password",
                              labelStyle: const TextStyle(
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.031),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(37, 43, 51, 1),
                            ),
                          ),
                          onPressed: (() {}),
                          child: const Center(
                            child: Text('Register'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.21,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const SignInPage())),
                                (route) => false),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
