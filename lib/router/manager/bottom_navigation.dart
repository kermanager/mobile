import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ManagerBottomNavigation extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ManagerBottomNavigation({
    super.key,
    required this.navigationShell,
  });

  @override
  State<ManagerBottomNavigation> createState() =>
      _ManagerBottomNavigationState();
}

class _ManagerBottomNavigationState extends State<ManagerBottomNavigation> {
  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _refreshData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return widget.navigationShell;
          }
          return Container();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.navigationShell.currentIndex,
        onTap: _goBranch,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Kermesses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
