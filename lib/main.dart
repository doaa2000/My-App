import 'package:flutter/material.dart';
import 'package:my_app/core/utils/api_services.dart';
import 'package:my_app/features/login_screen/presentiation/manager/auth_cubit/auth_cubit.dart';
import 'package:my_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_app/features/users_screen/presentiation/manager/cubit/users_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => authCubit(ApiService()),
        ),
        BlocProvider(
          create: (context) => UsersCubit(ApiService()),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'my app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const LoginView(),
      ),
    );
  }
}
