import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  toView(Widget view) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => view));
  }
}
