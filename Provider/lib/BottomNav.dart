import 'package:flutter/material.dart';
import 'screens/HomeScreen.dart';
import 'screens/BookingScreen.dart';
import 'screens/NotificationScreen.dart';
import 'screens/AccountScreen.dart';
import 'widgets/CustomStatusBar.dart';

class BottomNav extends StatefulWidget {
  final int initialIndex;
  final Function(int)? onTabChanged;
  
  const BottomNav({super.key, this.initialIndex = 0, this.onTabChanged});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  // List of screens for each tab
  List<Widget> get _screens => [
    HomeScreen(onNavigateToTab: (index) {
      setState(() {
        _currentIndex = index;
      });
      if (widget.onTabChanged != null) {
        widget.onTabChanged!(index);
      }
    }),
    const BookingScreen(),
    const NotificationScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Status Bar - Always visible
          const CustomStatusBar(),
          
          // Main Content Area - Changes based on navigation
          Expanded(
            child: _screens[_currentIndex],
          ),
        ],
      ),
      
      // Bottom Navigation Bar - Always visible (412 x 98)
      bottomNavigationBar: Container(
        height: 98,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Navigation section (74px)
            SizedBox(
              height: 74,
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  if (widget.onTabChanged != null) {
                    widget.onTabChanged!(index);
                  } else {
                    setState(() {
                      _currentIndex = index;
                    });
                  }
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: const Color(0xFF405FF2),
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      _currentIndex == 0
                          ? Icons.home_rounded
                          : Icons.home_outlined,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      _currentIndex == 1
                          ? Icons.confirmation_number
                          : Icons.confirmation_number_outlined,
                    ),
                    label: 'Booking',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      _currentIndex == 2
                          ? Icons.notifications
                          : Icons.notifications_none,
                    ),
                    label: 'Notification',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      _currentIndex == 3
                          ? Icons.account_box
                          : Icons.account_box_outlined,
                    ),
                    label: 'Account',
                  ),
                ],
              ),
            ),
            // Black indicator bar at bottom (24px remaining for 98 total)
            Container(
              width: 120,
              height: 5,
              margin: const EdgeInsets.only(top: 8, bottom: 11),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
