import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showHomeButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showHomeButton = true,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: showHomeButton
        ? IconButton(
            icon: const Icon(Icons.home),
            onPressed: () { Navigator.of(context).popUntil((route) => route.isFirst); },
          )
        : null,
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () { Scaffold.of(context).openEndDrawer(); }, 
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}