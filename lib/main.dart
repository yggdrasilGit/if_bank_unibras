import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brand Guidelines',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE2E8F0)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const BrandGuidelinesPage(),
    );
  }
}

class BrandGuidelinesPage extends StatelessWidget {
  const BrandGuidelinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("BRAND GUIDELINES"),
        actions: [
          IconButton(
            onPressed: () => print("natalha"),
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF0F172A),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/logo_if_bank.svg',
                  width: 96,
                  height: 96,
                ),
                const SizedBox(height: 34),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'if',
                        style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFF4F5F7),
                          height: 1,
                        ),
                      ),
                      TextSpan(
                        text: 'Bank',
                        style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF4F5F7),
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Uma identidade moderna que combina solidez arquitetônica, organização de dados e confiança institucional.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF4F5F7),
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Design Concept',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 12),
                Text(
                  'O monograma integra perfeitamente as letras “i” e “f” formando uma silhueta estruturada de “B”. Inspirado em arquitetura de software e sistemas modulares, o símbolo comunica estabilidade, segurança e precisão digital, refletindo uma instituição financeira construída para a era tecnológica.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Color(0xFF334155),
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Variações da Marca',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Desenvolvida para garantir escalabilidade em interfaces digitais de banking e ambientes corporativos.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 24),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      width: 145,
                      height: 145,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFD9DEE7),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/logo_fundo_claro_if_bank.svg',
                            width: 48,
                            height: 48,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Fundo Claro',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 145,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Center(child: Placeholder()),
                    ),
                    Container(
                      height: 145,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Center(child: Placeholder()),
                    ),
                    Container(
                      height: 145,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Placeholder(),
                    ),
                  ],
                ),
                Divider(),

                Container(
                  width: double.infinity,
                  height: 408,
                  child: Column(
                    children: [
                      Text(
                        'Paleta de Cores',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Uma paleta tecnológica sóbria e confiável, pensada para transmitir segurança financeira e solidez institucional.',
                      ),
                      SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        height: 66,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xff0F172A),
                              ),
                            ),

                            Column(
                              children: [
                                Text(
                                  '     Deep Navy',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text('#0F172A'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        height: 66,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xff475569),
                              ),
                            ),

                            Column(
                              children: [
                                Text(
                                  '     Graphite Gray',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text('#475569'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        height: 66,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xff10B981),
                              ),
                            ),

                            Column(
                              children: [
                                Text(
                                  '     Tech Green',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text('#10B981'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(width: double.infinity, height: 430),
        ],
      ),
    );
  }
}
