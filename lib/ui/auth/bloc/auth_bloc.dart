import 'package:app/common/exceptins.dart';
import 'package:app/data/repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isLoginMode;
  final IAuthRepository authRepository;
  AuthBloc(this.authRepository, {this.isLoginMode = true})
    : super(AuthInitial(isLoginMode)) {
    on<AuthEvent>((event, emit) async {
     try{
       if (event is AuthButtonIsClicked) {
        emit(AuthLoading(isLoginMode));
        if (isLoginMode) {
          await authRepository.login(event.username, event.password);
          emit(AuthSuccess(isLoginMode));
        } else {
          authRepository.signUp(event.username, event.password);
          emit(AuthSuccess(isLoginMode));
        }
      } else if (event is AuthModeChangeISClicked) {
        isLoginMode = !isLoginMode;
        emit(AuthInitial(isLoginMode));
      }
     }catch(e){
emit(AuthError(isLoginMode, AppExceotions()));
     }
    });
  }
}
