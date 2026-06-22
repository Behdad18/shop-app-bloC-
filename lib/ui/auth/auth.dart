import 'package:app/data/repository/auth_repository.dart';
import 'package:app/ui/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernameController = TextEditingController(
    text: 'test@gmail.com',
  );
  final TextEditingController passwordController = TextEditingController(
    text: '123456',
  );
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final onBackground = Colors.white;
    //change theme for this screen
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: themeData.copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(Size.fromHeight(56)),
              foregroundColor: WidgetStateProperty.all(
                themeData.colorScheme.secondary,
              ),
            ),
          ),
          colorScheme: themeData.colorScheme.copyWith(onSurface: onBackground),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: onBackground),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: onBackground, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              // اضافه کنید
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: onBackground, width: 1),
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: themeData.colorScheme.secondary,
          body: BlocProvider(
            create: (context) {
              final bloc = AuthBloc(authRepository);
              bloc.add(AuthStarted());
              bloc.stream.forEach((state) {
                if (state is AuthSuccess) {
                  Navigator.of(context).pop();
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.appExceotions.message)),
                  );
                }
              });
              return bloc;
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 32, left: 32),
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) {
                  return current is AuthLoading ||
                      current is AuthInitial ||
                      current is AuthError;
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/nike_logo.png',
                        width: 100,
                        color: Colors.white,
                      ),
                      SizedBox(height: 24),
                      Text(
                        state.isLoginMode ? 'خوش امدید' : 'ثبت نام',
                        style: TextStyle(color: onBackground, fontSize: 22),
                      ),
                      SizedBox(height: 16),
                      Text(
                        state.isLoginMode
                            ? 'لطفا وارد حساب کاربری خود شوید'
                            : 'ایمیل و رمز عبور خود را تعیین کنید',
                        style: TextStyle(color: onBackground, fontSize: 22),
                      ),
                      SizedBox(height: 24),
                      TextField(
                        controller: usernameController,
                        style: TextStyle(color: onBackground),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(label: Text('ادرس ایمیل')),
                      ),
                      SizedBox(height: 18),
                      _PasswordTextField(
                        onBackground: onBackground,
                        controller: passwordController,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthButtonIsClicked(
                              username: usernameController.text,
                              password: passwordController.text,
                            ),
                          );
                        },
                        child:
                            state is AuthLoading
                                ? CircularProgressIndicator()
                                : Text(state.isLoginMode ? 'ورود' : 'ثبت نام'),
                      ),
                      SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthBloc>(
                            context,
                          ).add(AuthModeChangeISClicked());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.isLoginMode
                                  ? 'حساب کاربری ندارید؟'
                                  : 'حساب کاربری دارید؟',
                              style: TextStyle(
                                color: onBackground.withOpacity(0.7),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              state.isLoginMode ? 'ثبت نام' : 'ورود',
                              style: TextStyle(
                                color: themeData.colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required this.onBackground,
    required this.controller,
  });

  final Color onBackground;
  final TextEditingController controller;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obsecureText = true;

  _PasswordTextFieldState();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: TextStyle(color: widget.onBackground),
      keyboardType: TextInputType.visiblePassword,
      obscureText: obsecureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obsecureText = !obsecureText;
            });
          },
          icon: Icon(
            obsecureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: widget.onBackground.withOpacity(0.6),
          ),
        ),
        label: Text('رمز عبور'),
      ),
    );
  }
}
