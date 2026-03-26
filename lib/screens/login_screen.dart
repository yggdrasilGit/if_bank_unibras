/// ============================================================
/// Arquivo: login_screen.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Tela responsável por renderizar a interface de login do usuário.
///
///
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Construir a UI da tela de login
/// - Integrar widgets
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Camada:
/// → Presentation (View)
///
/// Padrão:
/// → MVVM (Model-View-ViewModel)
///
/// Comunicação:
///
/// View → ViewModel (ações)
/// ViewModel → View (estado)
///
/// ------------------------------------------------------------
///
/// Dependências externas:
///
/// - flutter/material.dart
/// - import 'package:flutter_svg/svg.dart';
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
///
/// ------------------------------------------------------------
///
/// Estrutura da UI:
///
/// LoginPage
///  └── Scaffold
///       └── SafeArea
///            └── Center
///                 └── Colunm
///                     └── SvgPitures
///                     └── Text
///                     └── Text
///
///
///
/// ------------------------------------------------------------
///
/// Fluxo de execução:
///
///
///
/// ------------------------------------------------------------
///
/// Gerenciamento de estado:
///
///
///
/// ------------------------------------------------------------
///
/// Feedback ao usuário:
///
///
/// ------------------------------------------------------------
///
/// Boas práticas:
///
library;

///
/// ------------------------------------------------------------
///
/// Responsividade:
///

///
/// ------------------------------------------------------------
///
/// Restrições:
///
/// NÃO deve conter:
///
/// - Regras de negócio
/// - Chamadas diretas de API
/// - Validações complexas
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
///
/// Criado em: 19/03/2026
/// Última modificação: 19/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 19/03/2026 | Francismar  | Implentação da estrutua inicial
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SvgPicture.asset("assets/images/logo_if_bank.svg"),

              Text(
                "IF Bank",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 24),
              Text("Acesse sua conta"),
              SizedBox(height: 24),

              TextField(decoration: InputDecoration(labelText: 'Nome')),
              SizedBox(height: 24),
              TextField(decoration: InputDecoration(labelText: 'Senha')),

              Container(
                width: double.maxFinite,
                child: Text('Esqueci minha senha'),
              ),
              SizedBox(height: 16),

              ElevatedButton(onPressed: () {}, child: Text("Acessar")),

              Container(
                width: double.maxFinite,
                alignment: AlignmentGeometry.bottomRight,
                child: Text('Cadastrar conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
