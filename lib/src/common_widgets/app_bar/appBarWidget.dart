

import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {

  final IconData prefixIcon;
  final VoidCallback onTap;

  const AppBarButton({
    super.key, required this.prefixIcon, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        prefixIcon,
        color: Colors.black,
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  final String title ;
  const AppBarTitle({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context).textTheme.headlineMedium);
  }
}

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}