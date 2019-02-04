import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'package:services_app/routes.dart';
import 'package:services_app/middlewares/auth_middleware.dart';
import 'package:services_app/reducers/app_reducer.dart';
import 'colors.dart';
import 'localizations.dart';
import 'package:services_app/models/app_state.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  MainApp();

  @override
  Widget build(BuildContext context) {
    final String title = 'Rm2';
    var store = new Store<AppState>(
      appReducer,
      initialState: new AppState(),
      distinct: true,
      middleware: []
        ..addAll(createAuthMiddleware(context))
        ..add(new LoggingMiddleware.printer()), //new
    );

    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          Locale('en',''), 
          Locale('es',''),
        ],
        theme: _recomTheme,
        title: title,
        routes: getRoutes(context, store),
        initialRoute: '/login',
      ),
    );
  }
}



final ThemeData _recomTheme = _buildRecomTheme();

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: recomPrimaAccentColor);
}

ThemeData _buildRecomTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: recomPrimaAccentColor,
    primaryColor: recomPrimaColor,
    scaffoldBackgroundColor: recomBackgColor,
    cardColor: recomBackgColor,
    textSelectionColor: recomSelecColor,
    errorColor: recomErrorColor,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: recomSelecColor,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: recomPrimaAccentColor),
    //inputDecorationTheme: InputDecorationTheme(
    //  border: CutCornersBorder(),
    //),
    //textTheme: _buildShrineTextTheme(base.textTheme),
    //primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    //accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}
