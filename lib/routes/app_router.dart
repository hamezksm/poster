import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/dashboard/dashboard_screen.dart';
import '../presentation/screens/post_detail/post_detail_screen.dart';
import '../presentation/screens/posts_list/posts_list_screen.dart';

/// Application routes configuration using GoRouter
class AppRouter {
  static const String dashboard = '/';
  static const String posts = '/posts';
  static const String postDetail = '/posts/:id';

  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: dashboard,
      routes: [
        GoRoute(
          path: dashboard,
          name: 'dashboard',
          pageBuilder: (context, state) =>
              MaterialPage(key: state.pageKey, child: const DashboardScreen()),
        ),
        GoRoute(
          path: posts,
          name: 'posts',
          pageBuilder: (context, state) =>
              MaterialPage(key: state.pageKey, child: const PostsListScreen()),
        ),
        GoRoute(
          path: postDetail,
          name: 'postDetail',
          pageBuilder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '');
            if (id == null) {
              return MaterialPage(
                key: state.pageKey,
                child: const Scaffold(
                  body: Center(child: Text('Invalid post ID')),
                ),
              );
            }
            return MaterialPage(
              key: state.pageKey,
              child: PostDetailScreen(postId: id),
            );
          },
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                '404 - Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => context.go(dashboard),
                child: const Text('Go to Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
