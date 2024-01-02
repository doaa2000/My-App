import 'package:flutter/material.dart';
import 'package:my_app/core/utils/colors.dart';
import 'package:my_app/core/utils/reusable_components.dart';
import 'package:my_app/features/users_screen/data/models/users_model/users_model/row.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.userRow});
  final UserRow userRow;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 35,
              ),
              const Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 9,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor:
                      userRow.isActive ?? true ? Colors.green : Colors.grey,
                  radius: 8,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title: userRow.enName ?? "",
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                  title: "Price: ${userRow.price}",
                  fontSize: 15,
                  color: Colors.grey),
            ],
          )
        ],
      ),
    );
  }
}
