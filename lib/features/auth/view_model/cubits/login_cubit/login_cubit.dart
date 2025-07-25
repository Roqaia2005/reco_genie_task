import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reco_genie_task/features/auth/services/auth_service.dart';
import 'package:reco_genie_task/features/auth/view_model/cubits/login_cubit/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  final AuthService authService;

  LoginCubit(this.authService) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      await authService.login(email, password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
