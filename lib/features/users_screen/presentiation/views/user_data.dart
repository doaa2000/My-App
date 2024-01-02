import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/utils/reusable_components.dart';
import 'package:my_app/features/users_screen/presentiation/manager/cubit/users_cubit.dart';
import 'package:my_app/features/users_screen/presentiation/views/widgets/user_item.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  void initState() {
    UsersCubit.get(context).fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      listenWhen: (previous, current) =>
          current is GetUsersSuccess ||
          current is GetUsersLoading ||
          current is GetUsersFailure,
      listener: (context, state) {
        if (state is GetUsersFailure) {
          showToastMessage(message: state.errorMessage, isError: true);
        }
      },
      builder: (context, state) {
        if (state is GetUsersSuccess) {
          return ListView.separated(
              itemBuilder: (context, index) =>
                  UserItem(userRow: state.usersModel.data!.rows![index]),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
              itemCount: state.usersModel.data!.rows!.length);
        } else {
          return const Center(child: LoadingView());
        }
      },
    );
  }
}
