import 'package:flutter/material.dart';
import 'package:trip_tales/src/widgets/button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          top: 40.0,
                          bottom: 170,
                        ),
                        child: Image.asset(
                          'assets/images/TripTales_logo.png',
                          height: 250.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Positioned(
                        left: 2,
                        bottom: 100,
                        child: Text(
                          'Live',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 2,
                        // Adjust the value to move the text outside the box
                        bottom: 50,
                        child: Text(
                          'Feel',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 2,
                        bottom: 0,
                        child: Text(
                          'Discover',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ButtonBar(
                  children: <Widget>[
                    CustomButton(
                        height: 20,
                        width: 140,
                        text: "Login",
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/register');
                        })
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.pushReplacementNamed(context, '/register');
                    //   },
                    //   child: Text('Create Account'),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
