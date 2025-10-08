/// API constants for JSONPlaceholder
class ApiConstants {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String postsEndpoint = '/posts';

  static String getPostEndpoint(int id) => '/posts/$id';
}
