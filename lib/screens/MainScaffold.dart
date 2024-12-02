import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedItemColor: const Color(0xFF80ba27),
          unselectedItemColor: const Color(0xFF878787),
          currentIndex: widget.navigationShell.currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), label: "Budget"),
            BottomNavigationBarItem(icon: Icon(null), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: "Reports"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Accounts"),
          ],
          onTap: (int index) => _onTap(context, index) ,
      ),
      floatingActionButton:  FloatingActionButton(
          onPressed: ()=> _onTap(context, 2),
          backgroundColor: const Color(0xFF80ba27),
          shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90.0)
          ),
          child: const Icon(Icons.add, color: Colors.white)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _onTap(BuildContext context, int index) {
    try{
      widget.navigationShell.goBranch(index, initialLocation: index == widget.navigationShell.currentIndex );

    }catch(e){
      StatefulNavigationShell.of(context).goBranch(0);
    }
  }
}
