import 'package:flutter/material.dart';

showMessage(BuildContext context, String err) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(err),
      ),
    );
