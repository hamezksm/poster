import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/services/api_service.dart';
import 'data/repositories/post_repository.dart';
import 'presentation/providers/posts_provider.dart';
import 'routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    final apiService = ApiService();
    final postRepository = PostRepository(apiService);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostsProvider(postRepository)),
      ],
      child: MaterialApp.router(
        title: 'Posts Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.createRouter(),
      ),
    );
  }
}
