import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'theme/app_theme.dart';
import 'providers/crop_provider.dart';
import 'providers/expense_provider.dart';
import 'screens/home_screen.dart';
import 'screens/crops_screen.dart';
import 'screens/disease_screen.dart';
import 'screens/expenses_screen.dart';
import 'screens/dealers_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CropProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
      ],
      child: const AgriSenseApp(),
    ),
  );
}

class AgriSenseApp extends StatelessWidget {
  const AgriSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriSense',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AppEntry(),
    );
  }
}

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});
  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  String? _role;
  @override
  Widget build(BuildContext context) {
    if (_role == null) {
      return LoginScreen(onLogin: (role) => setState(() => _role = role));
    }
    return MainNavigation(role: _role!, onLogout: () => setState(() => _role = null));
  }
}

class MainNavigation extends StatefulWidget {
  final String role;
  final VoidCallback onLogout;
  const MainNavigation({super.key, required this.role, required this.onLogout});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isFarmer = widget.role == 'Farmer';
    final List<Widget> screens = isFarmer
        ? const [HomeScreen(), CropsScreen(), DiseaseScreen(), ExpensesScreen(), DealersScreen()]
        : const [DealersScreen(), HomeScreen()];
    if (_currentIndex >= screens.length) _currentIndex = 0;
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        tooltip: 'Log out',
        onPressed: widget.onLogout,
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.logout_rounded, color: Colors.white),
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);
          },
          backgroundColor: Colors.white,
          indicatorColor: AppTheme.primary.withOpacity(0.12),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          animationDuration: const Duration(milliseconds: 400),
          destinations: isFarmer ? const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.grass_outlined),
              selectedIcon: Icon(Icons.grass_rounded),
              label: 'Crops',
            ),
            NavigationDestination(
              icon: Icon(Icons.camera_alt_outlined),
              selectedIcon: Icon(Icons.camera_alt_rounded),
              label: 'Disease',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              selectedIcon: Icon(Icons.account_balance_wallet_rounded),
              label: 'Expenses',
            ),
            NavigationDestination(
              icon: Icon(Icons.store_outlined),
              selectedIcon: Icon(Icons.store_rounded),
              label: 'Dealers',
            ),
          ] : const [
            NavigationDestination(icon: Icon(Icons.store_outlined), selectedIcon: Icon(Icons.store_rounded), label: 'Dealer Hub'),
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Overview'),
          ],
        ),
      ),
    );
  }
}