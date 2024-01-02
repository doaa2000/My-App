import 'package:flutter/material.dart';
import 'package:my_app/core/utils/colors.dart';
import 'package:my_app/features/login_screen/presentiation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<authCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = authCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: const TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: AppColors.primaryColor,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), label: 'users'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'profile'),
              ]),
        );
      },
    );
  }
}
