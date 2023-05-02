import 'package:flutter/material.dart';

class ChangeNotifierBuilder<T extends ChangeNotifier> extends StatefulWidget {
  const ChangeNotifierBuilder({
    super.key,
    required this.builder,
    required this.listenable,
  });
  final Widget Function(BuildContext context, T listenable) builder;
  final T listenable;
  @override
  State<ChangeNotifierBuilder<T>> createState() =>
      _ChangeNotifierBuilderState<T>();
}

class _ChangeNotifierBuilderState<T extends ChangeNotifier>
    extends State<ChangeNotifierBuilder<T>> {
  @override
  void dispose() {
    widget.listenable.removeListener(listener);
    super.dispose();
  }

  listener() {
    setState(() {});
  }

  @override
  void initState() {
    widget.listenable.addListener(listener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.listenable);
  }
}