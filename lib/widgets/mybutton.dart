import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.color = mainButtonColorColor});
  final Color color;
  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      color: color,
      onPressed: onPressed,
      child: child,
    );
  }
}
