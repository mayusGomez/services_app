import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:services_app/actions/auth_actions.dart';
import 'package:services_app/models/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware(context) {
  final logIn = _createLogInMiddleware(context);
  final logOut = _createLogOutMiddleware();
  return [
    new TypedMiddleware<AppState, LogIn>(logIn),
    new TypedMiddleware<AppState, LogOut>(logOut)
  ];
}

Middleware<AppState> _createLogInMiddleware(context) {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = new GoogleSignIn();
    
    if (action is LogIn) {
      try {
        GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        // FirebaseUser user = await _auth.signInWithCustomToken(token:googleAuth.accessToken);
        FirebaseUser user = await _auth.signInWithGoogle(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        print('Logged in ${user.displayName}');
        store.dispatch(new LogInSuccessful(user: user));
      } catch (error) {
        store.dispatch(new LogInFail(error));
      }
    }
  };
}

Middleware<AppState> _createLogOutMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (action is LogOut) {
      try {
        await _auth.signOut();
        print('logging out...');
        store.dispatch(new LogOutSuccessful());
      } catch (error) {
        store.dispatch(new LogOutFail(error));
      }
    }
  };
}
