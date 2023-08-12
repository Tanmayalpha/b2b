
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';

Widget btn({VoidCallback? onTap, String? title, double? height, double? width }) {
  return SizedBox(
    height: height ?? 40,
    width: width ?? 190,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,

        ),
        onPressed: onTap, child:  Text(title ?? '--',
    style: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16))),
  );
}