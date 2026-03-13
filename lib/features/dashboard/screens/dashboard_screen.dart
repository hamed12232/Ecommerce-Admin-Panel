import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/auth_service.dart';

/// Placeholder dashboard screen — replace with your real dashboard later.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: () async {
              try {
                await AuthService.instance.signOut();
              } catch (e) {
                if (context.mounted) {
                   ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error signing out: $e')),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.dashboard, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 24),
            Text(
              'Welcome, ${user?.email ?? 'Admin'}!',
              style: textTheme.headlineMedium ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'You are authenticated.',
              style: textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ) ?? const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
