// ! 1. ESTADO DEL PROVIDER

import 'package:flutter_teslo_app/features/shared/shared.dart';
class LoginFormProvider {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormProvider({
    this.isPosting = false, 
    this.isFormPosted = false, 
    this.isValid = false, 
    this.email = const Email.pure(), 
    this.password = const Password.pure()
  });

}
