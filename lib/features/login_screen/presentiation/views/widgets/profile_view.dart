import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/utils/colors.dart';
import 'package:my_app/core/utils/reusable_components.dart';
import 'package:my_app/features/login_screen/presentiation/manager/auth_cubit/auth_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<authCubit, AuthState>(
      listenWhen: (previous, current) => current is LoginSuccess,
      buildWhen: (previous, current) => current is LoginSuccess,
      listener: (context, state) {
        if (state is LogoutSuccess) {
          showToastMessage(
              message: 'You are logged out successfully', isError: false);
        }
      },
      builder: (context, state) {
        var cubit = authCubit.get(context).user;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      fontSize: 20,
                      color: AppColors.primaryColor,
                      title: "Name:  ${cubit?.firstName} ${cubit?.lastName} "),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                      fontSize: 20,
                      color: AppColors.primaryColor,
                      title: "Email:  ${cubit?.email} "),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                      fontSize: 20,
                      color: AppColors.primaryColor,
                      title: "Phone Number:  ${cubit?.phoneNumber} "),
                  const SizedBox(
                    height: 200,
                  ),
                  CustomButton(
                      onTap: () {
                        authCubit.get(context).userLogout();
                      },
                      textColor: Colors.white,
                      text: 'Logout',
                      buttonColor: AppColors.primaryColor),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
