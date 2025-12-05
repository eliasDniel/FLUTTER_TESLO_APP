import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/providers.dart';






final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.watch(authProvider.notifier);
  return GouRouterNotifier(authNotifier);
});

class GouRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;
  GouRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }
  AuthStatus get authStatus => _authStatus;
  set authStatus(AuthStatus status) {
    _authStatus = status;
    notifyListeners();
  }
}
