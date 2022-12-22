import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeroomsmobile/blocs/freerooms_bloc.dart';
import 'package:freeroomsmobile/blocs/update_bloc.dart';
import 'package:freeroomsmobile/screens/home/home.dart';
import 'package:freeroomsmobile/theme.dart';

void main() async {
  
  // Initialize App
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => FreeroomsBloc())
        ),
        BlocProvider(
          create: ((context) => UpdateBloc())
        ),
      ],
      child: MaterialApp(
          title: 'FreeRoomsMobile',
          debugShowCheckedModeBanner: false,
          showSemanticsDebugger: false,
          theme: theme,
          home: const HomeScreen()),
    );
  }
}
