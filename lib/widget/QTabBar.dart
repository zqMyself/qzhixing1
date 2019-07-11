

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
const double _kTabHeight = 10.0;
const double _kTextAndIconTabHeight = 10.0;
class QTabBar extends Tab{
  const QTabBar({
    Key key,
    this.text,
    this.icon,
    this.child,
  }) : assert(text != null || child != null || icon != null),
        assert(!(text != null && null != child)), // TODO(goderbauer): https://github.com/dart-lang/sdk/issues/34180
        super(key: key);

  /// The text to display as the tab's label.
  ///
  /// Must not be used in combination with [child].
  final String text;

  /// The widget to be used as the tab's label.
  ///
  /// Usually a [Text] widget, possibly wrapped in a [Semantics] widget.
  ///
  /// Must not be used in combination with [text].
  final Widget child;

  /// An icon to display as the tab's label.
  final Widget icon;

}