import 'package:app/data/auth_info.dart';
import 'package:app/data/repository/auth_repository.dart';
import 'package:app/ui/auth/auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('سبد خرید')),

      body: ValueListenableBuilder<AuthInfo?>(
        valueListenable: authRepository.authChangeNotifire,
        builder: (context, authState, child) {
          bool isAuthenticated =
              authState != null && authState.accessToken!.isNotEmpty;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isAuthenticated
                        ? 'خوش امدید'
                        : 'لطفا وارد حساب کاربری خود شوید',
                  ),
                  isAuthenticated?
                    ElevatedButton(
                      onPressed: () {
                        authRepository.signOut();
                      },
                      child: Text('خروج از حساب کاربری'),
                      
                      
                    ):
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context,rootNavigator: true).push(
                          MaterialPageRoute(builder: (context) => AuthScreen()),
                        );
                      },
                      child: Text('ورود'),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
