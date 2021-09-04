import 'package:chat_app/app_cubit/cubit.dart';
import 'package:chat_app/layouts/home_layout.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:hexcolor/hexcolor.dart';

import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, LoginStates state) {
          if (state is LoginSuccessState) {
            AppCubit.get(context).getData();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomeLayout(),
              ),
              (route) => false,
            );
          }
          if (state is UserCreateSuccessState) {
            AppCubit.get(context).getData();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomeLayout(),
              ),
              (route) => false,
            );
          }
        },
        builder: (BuildContext context, LoginStates state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: Text(
                cubit.isLogin ? 'Login' : 'Sign up',
              ),
            ),
            body: defaultBackground(
              context: context,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(42.0),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: (MediaQuery.of(context).size.width) / 15,
                    vertical: (MediaQuery.of(context).size.height) / 40,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          !cubit.isLogin
                                              ? BoxShadow(
                                                  color: Colors.grey,
                                                  offset:
                                                      Offset(0.0, 1.0), //(x,y)
                                                  blurRadius: 10.0,
                                                )
                                              : BoxShadow(),
                                        ],
                                        color: cubit.isLogin
                                            ? HexColor('#E9E4E4')
                                            : HexColor('#5D5E63'),
                                        borderRadius:
                                            BorderRadius.circular(28.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          cubit.changeLogin(login: false);
                                          nameController.text = '';
                                          emailController.text = '';
                                          phoneController.text = '';
                                          passwordController.text = '';
                                          confirmPasswordController.text = '';
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0,
                                          ),
                                          child: Text(
                                            'Sign up',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          cubit.isLogin
                                              ? BoxShadow(
                                                  color: Colors.grey,
                                                  offset:
                                                      Offset(0.0, 1.0), //(x,y)
                                                  blurRadius: 10.0,
                                                )
                                              : BoxShadow(),
                                        ],
                                        color: cubit.isLogin
                                            ? HexColor('#5D5E63')
                                            : HexColor('#E9E4E4'),
                                        borderRadius:
                                            BorderRadius.circular(28.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          cubit.changeLogin(login: true);
                                          emailController.text = '';
                                          passwordController.text = '';
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0,
                                          ),
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height) / 50,
                            ),
                            if (!cubit.isLogin)
                              defaultTextFormField(
                                controller: nameController,
                                validator: cubit.isLogin
                                    ? () {}
                                    : (value) {
                                        if (value.isEmpty)
                                          return 'name must not be empty';
                                        return null;
                                      },
                                type: TextInputType.name,
                                context: context,
                                hintText: 'Name',
                              ),
                            if (!cubit.isLogin)
                              SizedBox(
                                height:
                                    (MediaQuery.of(context).size.height) / 50,
                              ),
                            defaultTextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'email must not be empty';
                                return null;
                              },
                              onSubmit: () {},
                              type: TextInputType.emailAddress,
                              context: context,
                              hintText: 'Email address',
                            ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height) / 50,
                            ),
                            if (!cubit.isLogin)
                              defaultTextFormField(
                                controller: phoneController,
                                validator: cubit.isLogin
                                    ? () {}
                                    : (value) {
                                        if (value.isEmpty)
                                          return 'phone must not be empty';
                                        return null;
                                      },
                                onSubmit: () {},
                                type: TextInputType.phone,
                                context: context,
                                hintText: 'Phone',
                              ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height) / 50,
                            ),
                            defaultTextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value.length < 8)
                                  return 'password is too short';
                                return null;
                              },
                              onSubmit: () {},
                              type: TextInputType.visiblePassword,
                              context: context,
                              hintText: 'Password',
                              suffixIcon: cubit.hiddenPassword
                                  ? IconBroken.Show
                                  : IconBroken.Hide,
                              isPassword: cubit.hiddenPassword ? true : false,
                              suffixPressed: () {
                                cubit.changeHiddenPassword();
                              },
                            ),
                            if (!cubit.isLogin)
                              SizedBox(
                                height:
                                    (MediaQuery.of(context).size.height) / 50,
                              ),
                            if (!cubit.isLogin)
                              defaultTextFormField(
                                controller: confirmPasswordController,
                                validator: cubit.isLogin
                                    ? () {}
                                    : (String value) {
                                        if (value != passwordController.text)
                                          return 'not match';
                                        return null;
                                      },
                                onSubmit: () {},
                                type: TextInputType.visiblePassword,
                                context: context,
                                hintText: 'Confirm password',
                                suffixIcon: cubit.hiddenConfirmPassword
                                    ? IconBroken.Show
                                    : IconBroken.Hide,
                                isPassword:
                                    cubit.hiddenConfirmPassword ? true : false,
                                suffixPressed: () {
                                  cubit.changeHiddenConfirmPassword();
                                },
                              ),
                            if (!cubit.isLogin)
                              SizedBox(
                                height:
                                    (MediaQuery.of(context).size.height) / 50,
                              ),
                            if (cubit.isLogin)
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: MaterialButton(
                                  minWidth: 1.0,
                                  height: 1.0,
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                  child: Text(
                                    'forget password',
                                    style: TextStyle(
                                      color:
                                          HexColor('#060606').withOpacity(0.62),
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height) / 50,
                            ),
                            Conditional.single(
                              context: context,
                              conditionBuilder: (BuildContext context) {
                                if (cubit.isLogin)
                                  return state is! LoginLoadingState;

                                return state is! RegisterLoadingState;
                              },
                              widgetBuilder: (BuildContext context) =>
                                  Container(
                                decoration: BoxDecoration(
                                  color: HexColor('#5D5E63'),
                                  borderRadius: BorderRadius.circular(28.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 10.0,
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    if (!cubit.isLogin) {
                                      if (formKey.currentState!.validate()) {
                                        cubit.userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          name: nameController.text,
                                        );
                                      }
                                    } else {
                                      if (formKey.currentState!.validate()) {
                                        cubit.loginUser(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Text(
                                      cubit.isLogin ? 'Login' : 'Sign up',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              fallbackBuilder: (BuildContext context) =>
                                  defaultCircularProgressIndicator(),
                            ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height) / 50,
                            ),
                            Text('or'),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height) / 50,
                            ),
                            SignInButton(
                              Buttons.Facebook,
                              onPressed: () {},
                            ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height) / 50,
                            ),
                            SignInButton(
                              Buttons.Google,
                              onPressed: () {},
                            ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height) / 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
