class LogInWithEmailAndPasswordFailure{
  final String message;

  const LogInWithEmailAndPasswordFailure([this.message="An unknown error has occurred"]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code){
    switch(code){
      case 'weak-password':
        return const LogInWithEmailAndPasswordFailure('Please enter a stronger password');
        case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure('Invalid email');
        case 'email-already-in-use':
        return const LogInWithEmailAndPasswordFailure('Please enter a stronger password');
        case 'operation-not-allowed':
        return const LogInWithEmailAndPasswordFailure('Please enter a stronger password');
        case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure('Please enter a stronger password');
         default:
        return const LogInWithEmailAndPasswordFailure();
        
    }
  }
}