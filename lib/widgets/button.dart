import 'package:flutter/material.dart';

class StyledButton extends StatefulWidget {
  void Function() onPressed;
  Widget child;
  StyledButton({super.key, required this.onPressed, required this.child});

  @override
  State<StyledButton> createState() => _StyledButtonState();
}

class _StyledButtonState extends State<StyledButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: widget.onPressed, child: widget.child);
  }
}
