import 'package:flutter/material.dart';

class DashedBorderContainer extends Container {
  final double borderWidth;
  final Color borderColor;
  final List<double>? dashPattern;

  DashedBorderContainer({
    required Widget child,
    this.borderWidth = 1.0,
    this.borderColor = Colors.black,
    this.dashPattern,
  }) : super(
    child: child,
  );

  @override
  Decoration? get decoration {
    final border = Border(
      top: BorderSide(
        width: borderWidth,
        color: borderColor,
        style: BorderStyle.solid,
      ),
      bottom: BorderSide(
        width: borderWidth,
        color: borderColor,
        style: BorderStyle.solid,
      ),
      left: BorderSide(
        width: borderWidth,
        color: borderColor,
        style: BorderStyle.solid,
      ),
      right: BorderSide(
        width: borderWidth,
        color: borderColor,
        style: BorderStyle.solid,
      ),
    );

    if (dashPattern != null) {
      return BoxDecoration(
        border: border,
        borderRadius: BorderRadius.circular(4),
        shape: BoxShape.rectangle,
      );
    }

    return BoxDecoration(
      border: Border.fromBorderSide(
        BorderSide(
          width: borderWidth,
          color: borderColor,
          style: BorderStyle.solid,
        ),
      ),
      borderRadius: BorderRadius.circular(4),
      shape: BoxShape.rectangle,
    );
  }

  @override
  EdgeInsetsGeometry? get padding => super.padding ?? EdgeInsets.zero;
}
