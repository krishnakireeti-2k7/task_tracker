import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/providers/theme_provider.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(child: Text('Menu')),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text('Toggle Theme'),
            onTap: () {
              final currentTheme = ref.read(themeProvider);
              ref.read(themeProvider.notifier).state =
                  currentTheme == AppThemeModes.light
                      ? AppThemeModes.dark
                      : AppThemeModes.light;
            },
          ),
        ],
      ),
    );
  }
}
