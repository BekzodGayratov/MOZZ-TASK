import 'package:flutter/material.dart';

navigateToPage(BuildContext context, Widget widget) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
