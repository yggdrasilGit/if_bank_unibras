/// Falta adicionar as informações de autor, deixei essa tela como placeholder para fins de teste
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app/routes/app_routes.dart';
import '../core/widgets/app_top_bar.dart';

class HomePlaceholderScreen extends StatelessWidget {
  const HomePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const AppTopBar(
        title: 'Desconectar',
        showBackButton: true,
        fallbackRoute: AppRoutes.loginScreen,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/logo_if_bank.svg', height: 92),
                const SizedBox(height: 24),
                Text(
                  'Em andamento',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
