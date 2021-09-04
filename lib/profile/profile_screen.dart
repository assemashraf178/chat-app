import 'package:chat_app/app_cubit/cubit.dart';
import 'package:chat_app/app_cubit/states.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: Text('Edit Profile')),
      body: defaultBackground(
        context: context,
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {},
          builder: (BuildContext context, AppStates state) {
            var model = AppCubit.get(context).userModel;
            nameController.text = model.name.toString();
            emailController.text = model.email.toString();
            phoneController.text = model.phone.toString();
            bioController.text = model.bio.toString();
            return Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) => model.image != null,
              widgetBuilder: (BuildContext context) => Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 30.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (state is UpdateUserDataLoadingState)
                          Text('Updating Data'),
                        if (state is UpdateUserDataLoadingState)
                          LinearProgressIndicator(),
                        if (state is UpdateUserDataLoadingState)
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 50.0,
                          ),
                        if (state is UploadImageLoadingState)
                          Text('Uploading Image'),
                        if (state is UploadImageLoadingState)
                          LinearProgressIndicator(),
                        if (state is UploadImageLoadingState)
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 50.0,
                          ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 4.5,
                              child: CircleAvatar(
                                radius: MediaQuery.of(context).size.height / 10,
                                backgroundImage:
                                    AppCubit.get(context).imageFile == null
                                        ? NetworkImage(model.image.toString())
                                        : FileImage(AppCubit.get(context)
                                            .imageFile!) as ImageProvider,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height / 30,
                                  )),
                              child: IconButton(
                                onPressed: () {
                                  AppCubit.get(context)
                                      .getImage()
                                      .then((value) {
                                    if (AppCubit.get(context).imageFile !=
                                        null) {
                                      AppCubit.get(context).uploadImage();
                                    }
                                  }).catchError((error) {
                                    print(error.toString());
                                  });
                                },
                                icon: Icon(
                                  IconBroken.Camera,
                                  size: MediaQuery.of(context).size.height / 25,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50.0,
                        ),
                        defaultTextFormField(
                          context: context,
                          controller: nameController,
                          validator: (String value) {
                            if (value.isEmpty) return 'name must be not empty';
                            return null;
                          },
                          type: TextInputType.name,
                          hintText: 'Name',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50.0,
                        ),
                        defaultTextFormField(
                          context: context,
                          controller: emailController,
                          validator: (String value) {
                            if (value.isEmpty) return 'email must be not empty';
                            return null;
                          },
                          type: TextInputType.emailAddress,
                          hintText: 'Email',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50.0,
                        ),
                        defaultTextFormField(
                          context: context,
                          controller: phoneController,
                          validator: (String value) {
                            if (value.isEmpty) return 'phone must be not empty';
                            return null;
                          },
                          type: TextInputType.phone,
                          hintText: 'Phone',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50.0,
                        ),
                        defaultTextFormField(
                          context: context,
                          controller: bioController,
                          validator: (String value) {
                            if (value.isEmpty) return 'bio must be not empty';
                            return null;
                          },
                          type: TextInputType.text,
                          hintText: 'bio',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50.0,
                        ),
                        MaterialButton(
                          color: HexColor('#3D4756'),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AppCubit.get(context).updateUserData(
                                email: emailController.text,
                                phone: phoneController.text,
                                name: nameController.text,
                                bio: bioController.text,
                              );
                            }
                          },
                          child: Text(
                            'Update Data',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              fallbackBuilder: (BuildContext context) =>
                  defaultCircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
