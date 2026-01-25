import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final Widget destination;
  final String text;

  const NavigationButton({ super.key, required this.destination, required this.text });

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      alignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => destination)); },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: Text(text),
        ),
      ],
    );
  }
}