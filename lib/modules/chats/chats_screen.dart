import 'package:chat_app/app_cubit/cubit.dart';
import 'package:chat_app/app_cubit/states.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      AppCubit.get(context).getChats();
      return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) =>
                AppCubit.get(context).chats.length > 0,
            widgetBuilder: (BuildContext context) => ListView.separated(
              itemBuilder: (BuildContext context, int index) =>
                  buildChatsItem(context, AppCubit.get(context).chats[index]),
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: MediaQuery.of(context).size.height / 80.0,
              ),
              itemCount: AppCubit.get(context).chats.length,
            ),
            fallbackBuilder: (BuildContext context) => Center(
              child: Text(
                'No Chats yet',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      decoration: TextDecoration.underline,
                      color: Colors.white.withOpacity(0.5),
                    ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildChatsItem(BuildContext context, UserModel model) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ChatScreen(model: model)));
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
