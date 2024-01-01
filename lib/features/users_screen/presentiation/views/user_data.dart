import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/users_screen/presentiation/manager/cubit/users_cubit.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('user data')),
      body: BlocConsumer<UsersCubit, UsersState>(
        listenWhen: (previous, current) =>
            current is GetUsersSuccess ||
            current is GetUsersLoading ||
            current is GetUsersFailure,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetUsersSuccess) {
            return Center(
              child: Column(
                children: [
                  Text(state.usersModel.data?.rows?[0].arName ?? ''),
                  Text(state.usersModel.data?.rows?[0].enName ?? ''),
                ],
              ),
            );
          } else if (state is GetUsersFailure) {
            return Container(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(child: Text('oops'));
          }
        },
      ),
    );
  }
}
