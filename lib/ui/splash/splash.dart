import 'package:flutter/material.dart';
import 'package:planeta_uz/ui/sign_in/sign_in_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.03,
          right: MediaQuery.of(context).size.width * 0.055,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.085,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(16, 16, 15, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => SignInPage()),
                  ),
                );
              },
              child: const Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Center(
                      child: Text('Sign Up'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.arrow_forward),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
