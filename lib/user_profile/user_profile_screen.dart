import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/chat/chat_screen.dart';
import 'package:chat_app/modules/open_image/open_image_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UserProfileScreen extends StatelessWidget {
  final UserModel model;
  const UserProfileScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: Text(
          model.name.toString(),
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 40,
          ),
        ),
        centerTitle: true,
      ),
      body: defaultBackground(
        context: context,
        child: Padding(
          padding: EdgeInsets.all(
            (MediaQuery.of(context).size.height) / 50.0,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => OpenImageScreen(
                        image: model.image.toString(),
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height / 10,
                    backgroundImage: NetworkImage(model.image.toString())),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              Text(
                model.name.toString(),
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white.withOpacity(0.8),
                    ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100,
              ),
              Text(
                model.bio.toString(),
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white.withOpacity(0.5),
                    ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              MaterialButton(
                color: HexColor('#3D4756'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ChatScreen(
                                model: model,
                              )));
                },
                child: Text(
                  'Send message',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
