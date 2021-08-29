import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class Dialog extends StatelessWidget {
 
  const Dialog({
    Key key,
    this.child,
    this.insetAnimationDuration: const Duration(milliseconds: 100),
    this.insetAnimationCurve: Curves.decelerate,
  }) : super(key: key);

  final Widget child;

  final Duration insetAnimationDuration;

  final Curve insetAnimationCurve;

  Color _getColor(BuildContext context) {
    return Theme.of(context).dialogBackgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: new MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: new Center(
          child: new ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 280.0),
            child: new Material(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              elevation: 30.0,
              color: _getColor(context),
              type: MaterialType.card,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key key,
    this.title,
    this.titlePadding,
    this.content,
    this.contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.actions,
    this.semanticLabel,
  })  : assert(contentPadding != null),
        super(key: key);

  final Widget title;

  final EdgeInsetsGeometry titlePadding;

  final Widget content;

  final EdgeInsetsGeometry contentPadding;

  final List<Widget> actions;

  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    String label = semanticLabel;

    if (title != null) {
      children.add(new Padding(
        padding: titlePadding ??
            new EdgeInsets.fromLTRB(
                24.0, 24.0, 24.0, content == null ? 20.0 : 0.0),
        child: new DefaultTextStyle(
          style: Theme.of(context).textTheme.title,
          child: new Semantics(child: title, namesRoute: true),
        ),
      ));
    }

    if (content != null) {
      children.add(new Flexible(
        child: new Padding(
          padding: contentPadding,
          child: new DefaultTextStyle(
            style: Theme.of(context).textTheme.subhead,
            child: content,
          ),
        ),
      ));
    }

    if (actions != null) {
      children.add(new ButtonTheme(
        child: new ButtonBar(
          children: actions,
        ),
      ));
    }

    Widget dialogChild = new IntrinsicWidth(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );

    if (label != null)
      dialogChild =
          new Semantics(namesRoute: true, label: label, child: dialogChild);

    return new Dialog(child: dialogChild);
  }
}

class SimpleDialogOption extends StatelessWidget {
  /// Creates an option for a [SimpleDialog].
  const SimpleDialogOption({
    Key key,
    this.onPressed,
    this.child,
  }) : super(key: key);

  final VoidCallback onPressed;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          child: child),
    );
  }
}

class SimpleDialog extends StatelessWidget {
  const SimpleDialog({
    Key key,
    this.title,
    this.titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    this.children,
    this.contentPadding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
    this.semanticLabel,
  })  : assert(titlePadding != null),
        assert(contentPadding != null),
        super(key: key);

  final Widget title;

  final EdgeInsetsGeometry titlePadding;

  final List<Widget> children;

  final EdgeInsetsGeometry contentPadding;

  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final List<Widget> body = <Widget>[];
    String label = semanticLabel;

    if (title != null) {
      body.add(new Padding(
          padding: titlePadding,
          child: new DefaultTextStyle(
            style: Theme.of(context).textTheme.headline1,
            child: new Semantics(namesRoute: true, child: title),
          )));
    }

    if (children != null) {
      body.add(new Flexible(
          child: new SingleChildScrollView(
        padding: contentPadding,
        child: new ListBody(children: children),
      )));
    }

    Widget dialogChild = new IntrinsicWidth(
      stepWidth: 56.0,
      child: new ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: body,
        ),
      ),
    );

    if (label != null)
      dialogChild = new Semantics(
        namesRoute: true,
        label: label,
        child: dialogChild,
      );
    return new Dialog(child: dialogChild);
  }
}

class _DialogRoute<T> extends PopupRoute<T> {
  _DialogRoute({
    @required this.theme,
    bool barrierDismissible: true,
    this.barrierLabel,
    @required this.child,
    RouteSettings settings,
  })  : assert(barrierDismissible != null),
        _barrierDismissible = barrierDismissible,
        super(settings: settings);

  final Widget child;
  final ThemeData theme;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  Color get barrierColor => Colors.black54;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new SafeArea(
      child: new Builder(builder: (BuildContext context) {
        final Widget annotatedChild = new Semantics(
          child: child,
          scopesRoute: true,
          explicitChildNodes: true,
        );
        return theme != null
            ? new Theme(data: theme, child: annotatedChild)
            : annotatedChild;
      }),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(
        opacity: new CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child);
  }
}

Future<T> customShowDialog<T>({
  @required
      BuildContext context,
  bool barrierDismissible: true,
  @Deprecated(
      'Instead of using the "child" argument, return the child from a closure '
      'provided to the "builder" argument. This will ensure that the BuildContext '
      'is appropriate for widgets built in the dialog.')
      Widget child,
  WidgetBuilder builder,
}) {
  assert(child == null || builder == null);
  return Navigator.of(context, rootNavigator: true).push(new _DialogRoute<T>(
    child: child ?? new Builder(builder: builder),
    theme: Theme.of(context),
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
  ));
}
