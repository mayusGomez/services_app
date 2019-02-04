import 'package:flutter/material.dart';

import 'package:services_app/localizations.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context).title),
      ),
    );
  }
}
