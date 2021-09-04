import 'package:chat_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class OpenImageScreen extends StatelessWidget {
  final String image;
  const OpenImageScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.5),
      appBar: defaultAppBar(
        context: context,
        title: Text(''),
      ),
      body: Center(
        child: Padding(
            padding:
                EdgeInsets.all((MediaQuery.of(context).size.height / 100.0)),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: InteractiveViewer(
                scaleEnabled: true,
                child: Image(
                  image: NetworkImage(
                    image,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
