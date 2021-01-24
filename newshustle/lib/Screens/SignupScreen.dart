import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';
import 'package:newshustle/Screens/LoginScreen.dart';
import 'package:newshustle/Screens/VerifyEmail.dart';
import 'package:newshustle/Services/AuthService.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  String _name;
  String _password;
  String _email;

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
  bool isObscure = true;
  Icon iconLock = Icon(Icons.lock);
  Icon iconlockclosed = Icon(Icons.lock_open);
  String _error;
  Auth auth = Auth();

  Future<void> _signUp() async {
    if (_formkey.currentState.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }

      try {
        String uid = await auth
            .createUserwithEmailandPassword(_email, _password, _name)
            .then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (context) => VerifyEmail())));

                print("///");
        print("User Created with id:" + uid);
        // showDialog(
        //   context: (context),
        //   builder: (context) => AlertDialog(
        //     content: Text(
        //         'Your Account has been Successfully created! Please verify your mail.'),
        //   ),
        // );
        setState(() {
          _error = "New Account has Been Created";
        });
      } catch (e) {
        print(e);
        setState(() {
          _error = e.message;

          print(_error);
        });
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
                )));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
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
                    fontSize: 28,
                  ),
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
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Name',
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please Enter name';
                        } else if (val.length < 5) {
                          return 'Name should be atleast 5 Char';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      onChanged: (value) {
                        _name = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                      //  initialValue: 'email',
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
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
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
                        hintText: 'Password',
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please Enter Email';
                        } else if (val.length < 5) {
                          return 'Email should be atleast 5 Char';
                        }
                        return null;
                      },
                      //  initialValue: 'email',
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      obscureText: isObscure,
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    showAlertDialog(),
                    SizedBox(
                      height: 10.0,
                    ),
                    FlatButton(
                      color: Color(0xFF006BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: _signUp,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Sign up',
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
                      height: 10,
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
                                builder: (context) => LoginScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Log in',
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
