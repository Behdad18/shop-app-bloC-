import 'package:app/ui/cart.dart';
import 'package:app/ui/home/home.dart';
import 'package:app/ui/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _HomePageState();
}

class _HomePageState extends State<Root> {
  //current index of the selected tab
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const Cart(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 10, left: 10),
        child: Container(
          height: 80,
          decoration: BoxDecoration(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: BottomNavigationBar(
              backgroundColor: const Color.fromARGB(232, 243, 243, 243),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home,size: 21,),
                  label: 'خانه',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.cart,size: 21,),
                  label: 'سبدخرید',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person,size: 21,),
                  label: 'پروفایل',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
   // A function that is called when each item is clicked.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // change active tab index
    });
  }
}


  