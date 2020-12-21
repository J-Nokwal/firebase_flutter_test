import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/bloc/UserBloc/userLogIn_bloc.dart';
import 'package:firebase_test/pages/homePage.dart';
import 'package:firebase_test/pages/signUppage.dart';
import 'package:firebase_test/repositories/userRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class LoginPageParent extends StatelessWidget {
  final UserRepository userRepository;

  LoginPageParent({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserLogInBloc(userRepository: userRepository),
      child: LoginPAge(userRepository: userRepository),
    );
  }
}

class LoginPAge extends StatelessWidget {
  //TextEditingController emailCntrlr = TextEditingController();
  final _emailController = TextEditingController();
  //TextEditingController passCntrlr = TextEditingController();
  final _passwordController = TextEditingController();
  UserLogInBloc loginBloc;
  final UserRepository userRepository;

  LoginPAge({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<UserLogInBloc>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: BlocConsumer<UserLogInBloc, UserLogInState>(
                  listener: (context, state) {
                    if (state is UserLogInSuccessfullState) {
                      navigateToHomeScreen(context, state.user);
                    }
                  },
                  builder: (context, state) {
                    if (state is UserLogInInitialState) {
                      return buildInitialUi();
                    } else if (state is UserLogInLoadingState) {
                      return buildLoadingUi();
                    } else if (state is UserLogInFailureState) {
                      return buildFailureUi(state.message);
                    } else if (state is UserLogInSuccessfullState) {
                      // _emailController.text = "";
                      // _passwordController.text = "";
                      return Container();
                    } else
                      return Container();
                  },
                  // child: BlocBuilder<UserLogInBloc, UserLogInState>(
                  //   builder: (context, state) {
                  //     if (state is UserLogInInitialState) {
                  //       return buildInitialUi();
                  //     } else if (state is UserLogInLoadingState) {
                  //       return buildLoadingUi();
                  //     } else if (state is UserLogInFailureState) {
                  //       return buildFailureUi(state.message);
                  //     } else if (state is UserLogInSuccessfullState) {
                  //       _emailController.text = "";
                  //       _passwordController.text = "";
                  //       return Container();
                  //     } else
                  //       return Container();
                  //   },
                  // ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(5.0),
              //   child: TextField(
              //     controller: emailCntrlr,
              //     decoration: InputDecoration(
              //       errorStyle: TextStyle(color: Colors.white),
              //       filled: true,
              //       fillColor: Colors.white,
              //       border: OutlineInputBorder(),
              //       labelText: "E-mail",
              //       hintText: "E-mail",
              //     ),
              //     keyboardType: TextInputType.emailAddress,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your email address to continue';
                    }
                    return null;
                  },
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(5.0),
              //   child: TextField(
              //     controller: passCntrlr,
              //     decoration: InputDecoration(
              //       errorStyle: TextStyle(color: Colors.white),
              //       filled: true,
              //       fillColor: Colors.white,
              //       border: OutlineInputBorder(),
              //       labelText: "Password",
              //       hintText: "Password",
              //     ),
              //     keyboardType: TextInputType.visiblePassword,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: RaisedButton(
                      color: Colors.cyan,
                      child: Text("Login"),
                      textColor: Colors.white,
                      onPressed: () {
                        loginBloc.add(
                          LogInButtonPressedEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.cyan,
                      child: Text("Sign Up Now"),
                      textColor: Colors.white,
                      onPressed: () {
                        navigateToSignUpScreen(context);
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
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        "Enter Login Credentials",
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailureUi(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "Fail $message",
            style: TextStyle(color: Colors.red),
          ),
        ),
        buildInitialUi(),
      ],
    );
  }

  void navigateToHomeScreen(BuildContext context, User user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomePageParent(user: user, userRepository: userRepository);
    }));
  }

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignUpPageParent(userRepository: userRepository);
    }));
  }
}
