import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:obamahome/auth/services/authentication_service.dart';


class AuthenticationController extends StateNotifier<AsyncValue<User?>> {
  AuthenticationController({required this.authService})
      : super(const AsyncData<User?>(null));

  final FirebaseAuthService authService;

  Future<void> authenticate() async {
    state = const AsyncLoading<User?>();
    state = await AsyncValue.guard(() async {
      return authService.signInWithGoogle();
    });
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthenticationController, AsyncValue>(
  (ref) {
    return AuthenticationController(
      authService: ref.watch(authServiceProvider),
    );
  },
);
