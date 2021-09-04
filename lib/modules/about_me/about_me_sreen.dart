import 'package:chat_app/app_cubit/cubit.dart';
import 'package:chat_app/app_cubit/states.dart';
import 'package:chat_app/modules/login/login_screen.dart';
import 'package:chat_app/modules/open_image/open_image_screen.dart';
import 'package:chat_app/profile/profile_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/network/local/cashed_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';

class AboutMeScreen extends StatelessWidget {
  AboutMeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getData();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        var model = AppCubit.get(context).userModel;
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) => model.image != null,
          widgetBuilder: (BuildContext context) => Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height / 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: InkWell(
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
                      radius: MediaQuery.of(context).size.height / 8,
                      backgroundImage: NetworkImage(model.image.toString()),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50.0,
                ),
                Text(
                  model.name.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white.withOpacity(0.8)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 100.0,
                ),
                Text(
                  model.bio.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white.withOpacity(0.5)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: HexColor('#3D4756'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ProfileScreen()));
                        },
                        child: Text(
                          'Edit Profile',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 20,
                    ),
                    Expanded(
                      child: MaterialButton(
                        color: HexColor('#3D4756'),
                        onPressed: () {
                          CashedHelper.removeData(key: 'uId');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign out',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          fallbackBuilder: (BuildContext context) =>
              defaultCircularProgressIndicator(),
        );
      },
    );
  }
}
