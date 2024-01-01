import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_app/core/utils/colors.dart';
import 'package:my_app/core/utils/constatnts.dart';
import 'package:my_app/core/utils/reusable_components.dart';
import 'package:my_app/features/login_screen/presentiation/manager/auth_cubit/auth_cubit.dart';
import 'package:my_app/features/login_screen/presentiation/views/widgets/profile_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey();
    return BlocConsumer<authCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showToastMessage(message: state.errorMessage, isError: true);
          print(state.errorMessage);
        }
        if (state is LoginSuccess) {
          showToastMessage(
              message: 'You are logged in successfully', isError: false);

          Get.offAll(() => const ProfileView());
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primaryColor, Colors.white])),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Welcome to bookly app',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        )),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.primaryColor,
                                        blurRadius: 20,
                                        offset: const Offset(0, 10))
                                  ],
                                ),
                                child: Column(children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200] ??
                                                    Colors.grey))),
                                    child: LoginAndRegisterTextForm(
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your email';
                                          }
                                          return null;
                                        },
                                        controller: emailController,
                                        hintText: 'Email Address'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: LoginAndRegisterTextForm(
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          return null;
                                        },
                                        controller: passwordController,
                                        hintText: 'Password'),
                                  ),
                                ]),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              LoginAndRegisterButton(
                                text: 'Login',
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    authCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CustomTextWidget(
                                    text: "don't have an account?",
                                    color: Colors.black,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.offAll(() => const LoginView());
                                    },
                                    child: CustomTextWidget(
                                      text: "Sign up",
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ))),
          ]),
        ));
      },
    );
  }
}
