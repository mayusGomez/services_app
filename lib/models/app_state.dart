import 'package:firebase_auth/firebase_auth.dart';

class AppState {
  bool isLoading;
  FirebaseUser user;

  AppState({
    this.isLoading = false,
    this.user,
  });

  factory AppState.loading() => new AppState(isLoading: true);

  AppState copyWith({ bool isLoading}) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,             // new
    );
  }

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, user: ${user?.displayName ?? 'null'}}';
  }
}
