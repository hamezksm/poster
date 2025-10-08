import 'package:dio/dio.dart';
import '../models/post.dart';
import '../../core/constants/api_constants.dart';

/// Service for making API calls to JSONPlaceholder
class ApiService {
  final Dio _dio;

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
        ),
      );

  /// Fetch all posts from the API
  Future<List<Post>> getAllPosts() async {
    try {
      final response = await _dio.get(ApiConstants.postsEndpoint);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  /// Fetch a single post by ID
  Future<Post> getPostById(int id) async {
    try {
      final response = await _dio.get(ApiConstants.getPostEndpoint(id));

      if (response.statusCode == 200) {
        return Post.fromJson(response.data);
      } else {
        throw Exception('Failed to load post');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching post: $e');
    }
  }
}
