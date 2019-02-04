library routes;

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:services_app/presentation/login_screen.dart';
import 'package:services_app/presentation/home_screen.dart';
import 'package:services_app/presentation/loading_screen.dart';

import 'models/app_state.dart';

void updateRoute(AppState state, BuildContext context) {
  if (state.user != null) {
    Navigator.pushNamed(context, '/');
  }
}

Map<String, WidgetBuilder> getRoutes(context, store) {
  return {
    '/': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return new HomeScreen();
          },
        ),
    '/login': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return new LoginScreen();
          },
        ),
    '/loading': (BuildContext context) => new StoreBuilder<AppState>(
          onInit: (store) {
            var oldState = store.state.copyWith();
            store.onChange.listen((state) {
              if (state.user != oldState.user) {
                updateRoute(state, context);
                oldState = state.copyWith();
              }
            });
          },
          builder: (context, store) {
            return new LoadingPage();
          },
        ),
  };
}
