import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:chat_app/app_cubit/cubit.dart';
import 'package:chat_app/app_cubit/states.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:chat_app/user_profile/user_profile_screen.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ChatScreen extends StatefulWidget {
  final UserModel model;
  ChatScreen({Key? key, required this.model}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState(model: model);
}

class _ChatScreenState extends State<ChatScreen> {
  final UserModel model;
  _ChatScreenState({Key? key, required this.model}) : super();

  var messageController = TextEditingController();

  var listController = ScrollController();

  var keyboardVisibilityController = KeyboardVisibilityController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).messages = [];
    AppCubit.get(context).getMessages(receiverUid: model.uId.toString());
    AppCubit.get(context).setState();
    // listController.jumpTo(listController.position.maxScrollExtent);
  }

  bool emojiShowing = false;
  _onEmojiSelected(Emoji emoji) {
    messageController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: messageController.text.length));
  }

  _onBackspacePressed() {
    messageController
      ..text = messageController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: messageController.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      controller: keyboardVisibilityController,
      child: Builder(
        builder: (BuildContext context) {
          AppCubit.get(context).getMessages(receiverUid: model.uId.toString());

          return BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context, AppStates state) {},
            builder: (BuildContext context, AppStates state) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                listController.jumpTo(listController.position.maxScrollExtent);
                if (state is! TestState) {
                  AppCubit.get(context).messages = [];
                  AppCubit.get(context).setState();
                }
              });
              return GestureDetector(
                onTap: () {
                  setState(() {
                    emojiShowing = false;
                  });
                },
                child: Scaffold(
                  appBar: defaultAppBar(
                    actions: [
                      TextButton(
                        onPressed: () {
                          listController
                              .jumpTo(listController.position.maxScrollExtent);
                        },
                        child: Text(
                          'Go to bottom',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.white.withOpacity(0.4)),
                        ),
                      )
                    ],
                    title: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UserProfileScreen(model: model)));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: (MediaQuery.of(context).size.height) / 40,
                            backgroundImage: NetworkImage(
                              model.image.toString(),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.height / 55,
                          ),
                          Expanded(
                            child: Text(
                              model.name.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    centerTitle: true,
                    context: context,
                    fontSize: MediaQuery.of(context).size.height / 35,
                  ),
                  body: defaultBackground(
                    context: context,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Conditional.single(
                              context: context,
                              conditionBuilder: (BuildContext context) =>
                                  AppCubit.get(context).messages.length > 0,
                              widgetBuilder: (BuildContext context) =>
                                  ListView.separated(
                                controller: listController,
                                itemBuilder: (BuildContext context, int index) {
                                  var message =
                                      AppCubit.get(context).messages[index];
                                  if (uId == message.senderUid)
                                    return buildSender(context, message);
                                  else
                                    return buildReceiver(context, message);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80,
                                ),
                                itemCount:
                                    AppCubit.get(context).messages.length,
                              ),
                              fallbackBuilder: (BuildContext context) => Center(
                                child: Text(
                                  'No Chats yet',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        decoration: TextDecoration.underline,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 80.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: (MediaQuery.of(context).size.height) /
                                    100.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  (MediaQuery.of(context).size.height) / 25),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (messageController.text != '') {
                                      AppCubit.get(context).sendMessage(
                                        text: messageController.text,
                                        receiverUid: model.uId.toString(),
                                        userImage: model.image.toString(),
                                      );
                                      messageController.text = '';
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    minLines: 1,
                                    maxLines: 5,
                                    onTap: () {
                                      emojiShowing = false;
                                    },
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'text here',
                                      hintStyle:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      emojiShowing = !emojiShowing;
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    });
                                  },
                                  icon: Icon(
                                    Icons.emoji_emotions,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Offstage(
                            offstage: !emojiShowing,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                              child: EmojiPicker(
                                onEmojiSelected:
                                    (Category category, Emoji emoji) {
                                  print(emoji);
                                  _onEmojiSelected(emoji);
                                },
                                onBackspacePressed: _onBackspacePressed,
                                config: Config(
                                  columns: 6,
                                  // Issue: https://github.com/flutter/flutter/issues/28894
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  initCategory: Category.RECENT,
                                  bgColor: Colors.white.withOpacity(0.8),
                                  indicatorColor: Colors.blueGrey,
                                  iconColor: Colors.grey,
                                  iconColorSelected: Colors.blueGrey,
                                  progressIndicatorColor:
                                      Colors.blueGrey.withOpacity(0.8),
                                  backspaceColor: Colors.blueGrey,
                                  showRecentsTab: true,
                                  recentsLimit: 28,
                                  noRecentsText: 'No Recents',
                                  noRecentsStyle: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black26,
                                  ),
                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                  categoryIcons: const CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL,
                                  emojiSizeMax:
                                      MediaQuery.of(context).size.height / 32,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildReceiver(BuildContext context, MessageModel model) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: (MediaQuery.of(context).size.width) / 50.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(
                      (MediaQuery.of(context).size.height) / 85.0),
                  child: Text(
                    model.text.toString(),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(
                          (MediaQuery.of(context).size.width) / 25.0),
                      topRight: Radius.circular(
                          (MediaQuery.of(context).size.width) / 25.0),
                      topLeft: Radius.circular(
                          (MediaQuery.of(context).size.width) / 25.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildSender(BuildContext context, MessageModel model) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(
                      (MediaQuery.of(context).size.height) / 85.0),
                  child: AutoSizeText(
                    model.text.toString(),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          (MediaQuery.of(context).size.width) / 25.0),
                      topRight: Radius.circular(
                          (MediaQuery.of(context).size.width) / 25.0),
                      topLeft: Radius.circular(
                          (MediaQuery.of(context).size.width) / 25.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width) / 50.0,
          ),
        ],
      );
}
