import 'package:flutter/foundation.dart';
import '../../data/models/post.dart';
import '../../data/repositories/post_repository.dart';

/// Provider for managing posts state
class PostsProvider with ChangeNotifier {
  final PostRepository _repository;

  List<Post> _posts = [];
  Post? _currentPost;
  bool _isLoading = false;
  String? _error;

  PostsProvider(this._repository);

  List<Post> get posts => _posts;
  Post? get currentPost => _currentPost;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Fetch all posts
  Future<void> fetchPosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _posts = await _repository.getAllPosts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Fetch a single post by ID
  Future<void> fetchPostById(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentPost = await _repository.getPostById(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get posts count by user for chart data
  Map<int, int> getPostsCountByUser() {
    return _repository.getPostsCountByUser(_posts);
  }

  /// Search posts by query (searches in both ID and title)
  List<Post> searchPosts(String query) {
    if (query.isEmpty) return _posts;

    final lowerQuery = query.toLowerCase();
    return _posts.where((post) {
      return post.id.toString().contains(lowerQuery) ||
          post.title.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
