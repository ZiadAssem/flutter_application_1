class SignUpWithEmailAndPasswordFailure{
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message="An unknown error has occurred"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure('Please enter a stronger password');
        case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure('Invalid email');
        case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure('Please enter a stronger password');
        case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure('Please enter a stronger password');
        case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure('Please enter a stronger password');
         default:
        return const SignUpWithEmailAndPasswordFailure();
        
    }
  }
}