import 'package:eired/features/authentication/repository/auth_repository.dart';
import 'package:eired/features/authentication/usecases/authenticate_user.dart';
import 'package:eired/features/authentication/viewmodel/auth_viewmodel.dart';
import 'package:eired/features/authentication/views/signin_screen.dart';
import 'package:eired/features/todo_list/repository/todo_repository.dart';
import 'package:eired/features/todo_list/usecases/todo_crud.dart';
import 'package:eired/features/todo_list/viewmodel/todo_viewmodel.dart';
import 'package:eired/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(
              authenticateUserUsecase:
                  AuthenticateUserUsecase(authRepository: AuthRepository()))),
      ChangeNotifierProvider<TodoViewModel>(
        create: (context) => TodoViewModel(
            todoCrudUsecase: TodoCrudUsecase(todoRepository: TodoRepository())),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SigninScreen(),
    );
  }
}
