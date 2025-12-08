import 'package:flutter/material.dart';

class SmoothModalRoute<T> extends ModalRoute<T> {
  final WidgetBuilder builder;
  final Color? _barrierColor;
  final bool isDismissible;
  final bool enableDrag;

  SmoothModalRoute({
    required this.builder,
    Color? barrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
  }) : _barrierColor = barrierColor;

  @override
  Color? get barrierColor => _barrierColor;

  @override
  bool get opaque => false;

  @override
  String? get barrierLabel => 'Dismiss';

  @override
  bool get barrierDismissible => isDismissible;

  @override
  bool get maintainState => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              decoration: const BoxDecoration(
                color: Color(0xffF4F4F7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
                child: builder(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    final curve = Curves.easeOutCubic;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}
