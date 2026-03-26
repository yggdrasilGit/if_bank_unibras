import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final String? fallbackRoute;
  final List<Widget>? actions;

  const AppTopBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.fallbackRoute,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      leadingWidth: showBackButton ? 56 : 0,
      leading: showBackButton
          ? IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                  return;
                }
                if (fallbackRoute != null) {
                  Navigator.pushReplacementNamed(context, fallbackRoute!);
                }
              },
              icon: const Icon(Icons.arrow_back, size: 20),
              tooltip: 'Voltar',
            )
          : null,
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: actions,
    );
  }
}
