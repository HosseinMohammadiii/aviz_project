import 'package:flutter/material.dart';

class RegisterDetailsBusiness extends StatefulWidget {
  RegisterDetailsBusiness({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<RegisterDetailsBusiness> createState() =>
      _RegisterDetailsBusinessState();
}

class _RegisterDetailsBusinessState extends State<RegisterDetailsBusiness> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(widget.title),
      ),
    );
  }
}
