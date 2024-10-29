import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paymentsapp/src/constants/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      /*actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.comment),
          tooltip: 'Comment Icon',
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Setting Icon',
          onPressed: () {},
        ),
      ],*/
      backgroundColor: colorPrimario, //Colors.greenAccent[400],
      elevation: 50.0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        tooltip: 'Menu Icon',
        onPressed: () {
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyApp(),
            ),
          );*/
          Navigator.pop(context);
        },
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
