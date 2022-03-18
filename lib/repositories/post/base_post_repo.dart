import '/models/post.dart';

abstract class BasePostRepository {
  Future<void> addPost({required Post post});
  Future<void> deletePost({required String? postId});
  Future<List<Future<Post?>>> getRenterPosts();
}
