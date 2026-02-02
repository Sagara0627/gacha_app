import 'package:flutter/material.dart';
import './custom_app_bar.dart';
import './custom_drawer.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget? floatingActionButton;
  final bool showHomeButton;

  const CommonLayout({
    super.key,
    required this.child,
    required this.title,
    this.floatingActionButton,
    this.showHomeButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title, showHomeButton: showHomeButton),
      endDrawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: child,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}