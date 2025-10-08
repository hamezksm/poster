import '../models/post.dart';
import '../services/api_service.dart';

/// Repository for managing post data
class PostRepository {
  final ApiService _apiService;

  PostRepository(this._apiService);

  /// Get all posts
  Future<List<Post>> getAllPosts() async {
    return await _apiService.getAllPosts();
  }

  /// Get a single post by ID
  Future<Post> getPostById(int id) async {
    return await _apiService.getPostById(id);
  }

  /// Get posts count grouped by userId
  Map<int, int> getPostsCountByUser(List<Post> posts) {
    final Map<int, int> userPostCounts = {};

    for (var post in posts) {
      userPostCounts[post.userId] = (userPostCounts[post.userId] ?? 0) + 1;
    }

    return userPostCounts;
  }
}
