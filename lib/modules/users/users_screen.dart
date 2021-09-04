import 'package:chat_app/app_cubit/cubit.dart';
import 'package:chat_app/app_cubit/states.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/user_profile/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getUsers();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        var users = AppCubit.get(context).users;
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) => users.length > 0,
          widgetBuilder: (BuildContext context) => ListView.separated(
            itemBuilder: (BuildContext context, int index) => buildUsersList(
              context: context,
              model: users[index],
            ),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: MediaQuery.of(context).size.height / 80.0,
            ),
            itemCount: users.length,
          ),
          fallbackBuilder: (BuildContext context) => Center(
            child: Center(
              child: Text(
                'No Users yet',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      decoration: TextDecoration.underline,
                      color: Colors.white.withOpacity(0.5),
                    ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildUsersList({
    required BuildContext context,
    required UserModel model,
  }) =>
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      UserProfileScreen(model: model)));
        },
        child: Padding(
          padding: EdgeInsets.all(
            (MediaQuery.of(context).size.height) / 70.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: (MediaQuery.of(context).size.height) / 25,
                backgroundImage: NetworkImage(
                  model.image.toString(),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height / 55,
              ),
              Text(
                '${model.name.toString()}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
              ),
            ],
          ),
        ),
      );
}
