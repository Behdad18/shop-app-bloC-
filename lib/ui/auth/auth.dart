import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final onBackground = Colors.white;
    //change theme for this screen
    return Theme(
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
        body: Padding(
          padding: const EdgeInsets.only(right: 32, left: 32),
          child: Column(
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
               isLogin? 'خوش امدید':'ثبت نام',
                style: TextStyle(color: onBackground, fontSize: 22),
              ),
              SizedBox(height: 16),
              Text(
              isLogin?'لطفا وارد حساب کاربری خود شوید':'ایمیل و رمز عبور خود را تعیین کنید',
                style: TextStyle(color: onBackground, fontSize: 22),
              ),
              SizedBox(height: 24),
              TextField(
                style: TextStyle(color: onBackground),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(label: Text('ادرس ایمیل')),
              ),
              SizedBox(height: 18),
              _PasswordTextField(onBackground: onBackground),
              SizedBox(height: 16),
              ElevatedButton(onPressed: () {}, child: Text(isLogin? 'ورود':'ثبت نام')),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLogin=!isLogin;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    isLogin?  'حساب کاربری ندارید؟':'حساب کاربری دارید؟',
                      style: TextStyle(color: onBackground.withOpacity(0.7)),
                    ),
                    SizedBox(width:8),
                    Text(
                     isLogin? 'ثبت نام':'ورود',
                      style: TextStyle(
                        color: themeData.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({super.key, required this.onBackground});

  final Color onBackground;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
