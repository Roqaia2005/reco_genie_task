import 'package:bloc/bloc.dart';
import 'package:reco_genie_task/features/auth/services/auth_service.dart';


part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthService authService;

  SignupCubit(this.authService) : super(SignupInitial());

  Future<void> signup(String email, String password) async {
    emit(SignupLoading());
    try {
      await authService.signUp(email, password);
      emit(SignupSuccess());
    } catch (e) {
  
      emit(SignupFailure(e.toString()));
    }
  }
}
