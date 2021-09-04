import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  double elevation = 0.0,
  double? iconSize,
  double? fontSize,
  double titleSpacing = 0.0,
  Color iconColor = Colors.black,
  Color? titleColor,
  Color? backgroundColor,
  required Widget title,
  bool centerTitle = true,
  bool leading = true,
  Color? backColor,
  List<Widget>? actions,
}) =>
    AppBar(
      actions: actions,
      title: title,
      leading: leading
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: backColor == null
                    ? Colors.white.withOpacity(0.7)
                    : backColor,
                // color: backgroundColor,
              ),
            )
          : null,
      elevation: elevation,
      iconTheme: IconThemeData(
        color: iconColor,
        size: iconSize != null
            ? iconSize
            : MediaQuery.of(context).size.height / 27.0,
      ),
      titleSpacing: titleSpacing,
      titleTextStyle: TextStyle(
        fontFamily: 'Jannah',
        fontSize: fontSize != null
            ? fontSize
            : MediaQuery.of(context).size.height / 27.0,
        color: titleColor == null ? Colors.white.withOpacity(0.7) : titleColor,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backwardsCompatibility: false,
      backgroundColor: backgroundColor == null
          ? Colors.blueGrey[600] as Color
          : backgroundColor,
      centerTitle: centerTitle,
    );

Widget defaultTextFormField({
  required BuildContext context,
  required Function validator,
  Function? onSubmit,
  required TextInputType type,
  TextEditingController? controller,
  IconData? suffixIcon,
  String? hintText,
  Function? suffixPressed,
  bool isPassword = false,
  bool readOnly = false,
}) =>
    Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 10.0,
          ),
        ],
        color: HexColor('#3D4756'),
        borderRadius:
            BorderRadius.circular((MediaQuery.of(context).size.width) / 10.0),
      ),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        validator: (value) {
          return validator(value);
        },
        // onFieldSubmitted: (s) {
        //   onSubmit!(s);
        // },
        keyboardType: type,
        style: TextStyle(
          color: Colors.white,
        ),
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: (MediaQuery.of(context).size.width) / 25.0),
          hintText: hintText,
          suffix: suffixIcon != null
              ? InkWell(
                  onTap: () {
                    suffixPressed!();
                  },
                  child: Icon(
                    suffixIcon,
                    color: HexColor('#A8A7A7'),
                  ),
                )
              : null,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.42),
            textBaseline: TextBaseline.alphabetic,
          ),
          border: InputBorder.none,
        ),
      ),
    );

Widget defaultBackground({
  required BuildContext context,
  required Widget child,
}) =>
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/chat_background.png',
          ),
          fit: BoxFit.cover,
          alignment: Alignment.topLeft,
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(
          (MediaQuery.of(context).size.height) / 50,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              (MediaQuery.of(context).size.height) / 60.0),
          border: Border(
            top: BorderSide(
              color: Colors.white,
              width: 3.0,
            ),
            bottom: BorderSide(
              color: Colors.white,
              width: 3.0,
            ),
            left: BorderSide(
              color: Colors.white,
              width: 3.0,
            ),
            right: BorderSide(
              color: Colors.white,
              width: 3.0,
            ),
          ),
        ),
        child: child,
      ),
    );

Widget defaultCircularProgressIndicator() => Center(
      child: CircularProgressIndicator(
        color: Colors.blueGrey[700] as Color,
      ),
    );
