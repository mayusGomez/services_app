import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

import 'package:services_app/actions/auth_actions.dart';
import 'package:services_app/models/app_state.dart';
import 'package:services_app/presentation/google_button.dart';

class AuthButtonContainer extends StatelessWidget {

  AuthButtonContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return new GoogleAuthButton(
          onPressedCallback: () => vm.onPressedCallback(context),
        );
      },
    );
  }
}

class _ViewModel{
  final Function onPressedCallback;

  _ViewModel({ this.onPressedCallback });

  static _ViewModel fromStore(Store<AppState> store){
    return _ViewModel(
      onPressedCallback: (context){
        store.dispatch(new LogIn());
        Navigator.of(context).pushNamed('/loading');
      }
    );
  }
}