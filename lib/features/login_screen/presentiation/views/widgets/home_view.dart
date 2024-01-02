import 'package:flutter/material.dart';
import 'package:my_app/core/utils/assets.dart';
import 'package:my_app/core/utils/colors.dart';
import 'package:my_app/core/utils/reusable_components.dart';
import 'package:my_app/features/login_screen/presentiation/manager/auth_cubit/auth_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
                color: AppColors.primaryColor,
                fontSize: 35,
                fontWeight: FontWeight.w700,
                title: 'Welcome '),
            const Image(
                image: AssetImage(AppAssets.hiImage), height: 40, width: 40),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: TextWidget(
              color: AppColors.primaryColor,
              fontSize: 27,
              fontWeight: FontWeight.w700,
              title:
                  '${authCubit.get(context).user?.firstName} ${authCubit.get(context).user?.lastName}'),
        ),
      ],
    );
  }
}
