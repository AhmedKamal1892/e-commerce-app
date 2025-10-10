import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.titleText,
    this.actions,
    this.leading,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleText,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: leading,
        actions: actions,
        actionsIconTheme: IconThemeData(
          color: appBarTheme.foregroundColor?.withAlpha(150),
          size: 24,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white.withAlpha(50), height: 1.0),
        ),
        backgroundColor: appBarTheme.backgroundColor,
        elevation: appBarTheme.elevation,
        titleTextStyle: textTheme.titleLarge,
      ),
    );
  }
}
