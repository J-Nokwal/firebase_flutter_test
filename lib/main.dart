import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test/bloc/AuthBloc/auth_bloc.dart';
import 'package:firebase_test/pages/homePage.dart';
import 'package:firebase_test/pages/sigInPage.dart';
import 'package:firebase_test/pages/splashPage.dart';
import 'package:firebase_test/repositories/userRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      title: 'Material App',
      home: BlocProvider(
        create: (context) =>
            AuthBloc(userRepository: userRepository)..add(AppStartedEvent()),
        child: App(
          userRepository: userRepository,
        ), //userRepository: userRepository),
      ),
    );
  }
}

class App extends StatelessWidget {
  UserRepository userRepository;

  App({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitialState) {
          print("111k");
          return SplashPage();
        } else if (state is AuthenticatedState) {
          print("222k");
          return HomePageParent(
              user: state.user, userRepository: userRepository);
        } else if (state is UnAuthenticatedState) {
          print("333k");
          return LoginPageParent(userRepository: userRepository);
        }
      },
    );
  }
}
