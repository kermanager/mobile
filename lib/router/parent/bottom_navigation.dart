import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/theme/theme_size.dart';

class ParentBottomNavigation extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ParentBottomNavigation({
    super.key,
    required this.navigationShell,
  });

  @override
  State<ParentBottomNavigation> createState() => _ParentBottomNavigationState();
}

class _ParentBottomNavigationState extends State<ParentBottomNavigation> {
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
      bottomNavigationBar: SizedBox(
        height: ThemeSize.s80,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.navigationShell.currentIndex,
          onTap: _goBranch,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.celebration),
              label: 'Kermesses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Mes enfants',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_num),
              label: 'Tickets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
