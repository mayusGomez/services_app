import 'package:services_app/models/app_state.dart';
import 'package:services_app/reducers/auth_reducer.dart';

AppState appReducer(state, action) {
  return new AppState(
    isLoading: false,
    user: authReducer(state.user, action),
  ); 
}
