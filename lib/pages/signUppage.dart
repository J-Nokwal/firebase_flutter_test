import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/bloc/regbloc/userreg_bloc.dart';
import 'package:firebase_test/pages/homePage.dart';
import 'package:firebase_test/pages/sigInPage.dart';
import 'package:firebase_test/repositories/userRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

class SignUpPageParent extends StatelessWidget {
  final UserRepository userRepository;

  SignUpPageParent({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserRegBloc(userRepository: userRepository),
      child: SignUpPage(userRepository: userRepository),
    );
  }
}

class SignUpPage extends StatelessWidget {
  TextEditingController emailCntrl = TextEditingController();
  TextEditingController passCntrlr = TextEditingController();

  String authResult;
  UserRegBloc userRegBloc;
  final UserRepository userRepository;

  SignUpPage({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    userRegBloc = BlocProvider.of<UserRegBloc>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: BlocConsumer<UserRegBloc, UserRegState>(
                  listener: (context, state) {
                    if (state is UserRegSuccessfullState) {
                      navigateToHomePage(context, state.user);
                    }
                  },
                  builder: (context, state) {
                    if (state is UserRegInitialState) {
                      return buildInitialUi();
                    } else if (state is UserLoadingState) {
                      return buildLoadingUi();
                    } else if (state is UserRegFailure) {
                      return buildFailureUi(state.message);
                    } else if (state is UserRegSuccessfullState) {
                      // emailCntrl.text = "";
                      // passCntrlr.text = "";
                      return Container();
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  controller: emailCntrl,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: "E-mail",
                    hintText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  controller: passCntrlr,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Password",
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: RaisedButton(
                      color: Colors.cyan,
                      child: Text("Sign Up"),
                      textColor: Colors.white,
                      onPressed: () {
                        userRegBloc
                          ..add(SignUpButtonPressedEvent(
                              email: emailCntrl.text,
                              password: passCntrlr.text));
                      },
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.cyan,
                      child: Text("Login Now"),
                      textColor: Colors.white,
                      onPressed: () {
                        navigateToLoginPage(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInitialUi() {
    return Text("Waiting For Authentication");
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void navigateToHomePage(BuildContext context, User user) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePageParent(user: user, userRepository: userRepository);
    }));
  }

  Widget buildFailureUi(String message) {
    return Text(
      message,
      style: TextStyle(color: Colors.red),
    );
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginPageParent(userRepository: userRepository);
    }));
  }
}
