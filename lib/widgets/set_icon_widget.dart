import 'package:countries/components/colors.dart';
import 'package:flutter/material.dart';

Icon setIcon(
  IconData iconData, {
  Color? color,
  double? size,
}) =>
    Icon(
      iconData,
      size: size ?? 24,
      color: color ?? colorBlack,
    );

IconButton setIconButton(
  IconData iconData,
  VoidCallback onPressed, {
  Color? color,
  double? size,
}) =>
    IconButton(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        size: size ?? 24,
      ),
      color: color ?? colorBlack,
    );
