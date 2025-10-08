import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Navigation bar for switching between main routes
class AppNavigationBar extends StatelessWidget {
  final String currentRoute;

  const AppNavigationBar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 24,
          vertical: 12,
        ),
        child: Row(
          children: [
            // App Title/Logo
            Row(
              children: [
                const Icon(
                  Icons.article_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(width: 12),
                if (!isMobile)
                  const Text(
                    'Posts Manager',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
              ],
            ),
            if (!isMobile) const SizedBox(width: 48),
            const Spacer(),
            // Navigation buttons or menu
            if (isMobile)
              _buildMobileMenu(context)
            else
              Row(
                children: [
                  _buildNavButton(
                    context,
                    label: 'Dashboard',
                    icon: Icons.dashboard_outlined,
                    route: '/',
                    isActive: currentRoute == '/',
                  ),
                  const SizedBox(width: 12),
                  _buildNavButton(
                    context,
                    label: 'All Posts',
                    icon: Icons.list_alt,
                    route: '/posts',
                    isActive: currentRoute == '/posts',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: Colors.white, size: 28),
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: '/',
          child: Row(
            children: [
              Icon(
                Icons.dashboard_outlined,
                color: currentRoute == '/'
                    ? Colors.blue[700]
                    : Colors.grey[700],
              ),
              const SizedBox(width: 12),
              Text(
                'Dashboard',
                style: TextStyle(
                  fontWeight: currentRoute == '/'
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: currentRoute == '/'
                      ? Colors.blue[700]
                      : Colors.grey[900],
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: '/posts',
          child: Row(
            children: [
              Icon(
                Icons.list_alt,
                color: currentRoute == '/posts'
                    ? Colors.blue[700]
                    : Colors.grey[700],
              ),
              const SizedBox(width: 12),
              Text(
                'All Posts',
                style: TextStyle(
                  fontWeight: currentRoute == '/posts'
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: currentRoute == '/posts'
                      ? Colors.blue[700]
                      : Colors.grey[900],
                ),
              ),
            ],
          ),
        ),
      ],
      onSelected: (route) {
        if (route != currentRoute) {
          context.go(route);
        }
      },
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String route,
    required bool isActive,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isActive ? null : () => context.go(route),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isActive
                ? Colors.white.withValues(alpha: 0.25)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive
                  ? Colors.white.withValues(alpha: 0.5)
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
