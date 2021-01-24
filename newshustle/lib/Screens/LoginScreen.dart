import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'SignupScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newshustle/Screens/SignupScreen.dart';
import 'package:newshustle/Services/AuthService.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool isObscure = true;
  Icon iconLock = Icon(Icons.lock);
  Icon iconlockclosed = Icon(Icons.lock_open);
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 8),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  String _email, _password, _error;

  Auth auth = Auth();
  _login() async {
    if (_formkey.currentState.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      try {
        print(_email);

        final value =
            await auth.signinUserwithEmailandPassword(_email, _password);
        if (value != null) {
          setState(() {
            _error = "Signed in";
          });
        } else {
          setState(() {
            _error = "Verify your mail";
            showModalBottomSheet(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'News Hustle Alert',
                  textAlign: TextAlign.center,
                ),
                titlePadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                content: Container(
                  child: Column(
                    children: [
                      Text('Your Email is not Verified'),
                      FlatButton(
                        color: ThemeData.light().primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Colors.white, 
                            
                          )
                        ),
                        onPressed: () {
                          auth.sendemailVerification();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Send Verification Mail',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        }
      } catch (e) {
        setState(() {
          _error = e.message;
        });
        print(e.message);
      }
    }
  }

  Widget showAlertDialog() {
    return _error == null
        ? Container()
        : BottomSheet(
            onClosing: () {},
            builder: (context) => Center(
              child: Text(
                _error,
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget child) {
                    return ClipPath(
                      clipper: DrawClip(_controller.value),
                      child: Container(
                        height: size.height * 0.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [Color(0xFF006BFF), Color(0xFF006BFF)]),
                        ),
                      ),
                    );
                  },
                ),
                Text(
                  'Welcome Back',
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please Enter Email';
                        } else if (val.length < 5) {
                          return 'Email should be atleast 5 Char';
                        }
                        return null;
                      },
                      // initialValue: ,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            icon: isObscure ? iconLock : iconlockclosed,
                            onPressed: () {
                              setState(() {
                                if (isObscure == true) {
                                  this.isObscure = false;
                                } else {
                                  this.isObscure = true;
                                }
                              });
                            }),
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please Enter Password';
                        } else if (val.length < 5) {
                          return 'Password should be atleast 5 Char';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    showAlertDialog(),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Color(0xFF006BFF),
                      onPressed: _login,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Log in',
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.black)),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
