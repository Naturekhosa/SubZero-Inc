// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class linklist extends StatelessWidget {
  String link;
   linklist({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("link : "+link),
    );
  }
}