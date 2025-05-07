import 'package:flutter/material.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/shared/presentation/widgets/app_bars/simple_app_bar.dart';

class ReportBugScreen extends StatefulWidget {
  const ReportBugScreen({super.key});

  @override
  State<ReportBugScreen> createState() => _ReportBugScreenState();
}

class _ReportBugScreenState extends State<ReportBugScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Signaler un bug"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.send, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'Des difficultés au cours de l\'utilisation de cette application ? Envoyez-nous vos remarques.',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 15),
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      maxLines: 7,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      decoration: InputDecoration.collapsed(
                        hintText: 'Tapez votre message',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
