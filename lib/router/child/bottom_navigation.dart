import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChildBottomNavigation extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ChildBottomNavigation({
    super.key,
    required this.navigationShell,
  });

  @override
  State<ChildBottomNavigation> createState() => _ChildBottomNavigationState();
}

class _ChildBottomNavigationState extends State<ChildBottomNavigation> {
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
