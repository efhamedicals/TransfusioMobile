import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/shared/presentation/widgets/app_bars/simple_app_bar.dart';

class LegalAppScreen extends StatefulWidget {
  const LegalAppScreen({super.key});

  @override
  State<LegalAppScreen> createState() => _LegalAppScreenState();
}

class _LegalAppScreenState extends State<LegalAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Mentions légales"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                AppRouter.router.push(AppRouter.legalContent, extra: 1);
              },
              child: const ListTile(
                leading: FaIcon(FontAwesomeIcons.file),
                title: Text("Termes et conditions"),
                trailing: FaIcon(FontAwesomeIcons.angleRight, size: 14),
              ),
            ),
            const Divider(thickness: 2),
            GestureDetector(
              onTap: () {
                AppRouter.router.push(AppRouter.legalContent, extra: 2);
              },
              child: const ListTile(
                leading: FaIcon(FontAwesomeIcons.stop),
                title: Text("Politique de confidentialité"),
                trailing: FaIcon(FontAwesomeIcons.angleRight, size: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
