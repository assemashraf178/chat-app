import 'package:chat_app/app_cubit/cubit.dart';
import 'package:chat_app/app_cubit/states.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        var model = AppCubit.get(context).userModel;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: Text(
              AppCubit.get(context).titles[AppCubit.get(context).currentIndex],
            ),
            leading: false,
          ),
          bottomNavigationBar: Container(
            color: Colors.blueGrey[600],
            child: SalomonBottomBar(
              items: AppCubit.get(context).items,
              onTap: (int index) {
                AppCubit.get(context).changeNavBottomBarIndex(index);
              },
              currentIndex: AppCubit.get(context).currentIndex,
              itemPadding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width) / 15,
                vertical: (MediaQuery.of(context).size.height) / 65.0,
              ),
              selectedColorOpacity: 0.15,
            ),
          ),
          body: defaultBackground(
            context: context,
            child: AppCubit.get(context)
                .screens[AppCubit.get(context).currentIndex],
          ),
        );
      },
    );
  }
}
