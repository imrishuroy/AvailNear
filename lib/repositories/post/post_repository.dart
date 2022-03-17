import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finding_home/models/failure.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '/config/paths.dart';
import '/models/post.dart';
import '/repositories/post/base_post_repo.dart';

class PostRepository extends BasePostRepository {
  final FirebaseFirestore _firestore;

  PostRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addPost({required Post post}) async {
    try {
      await _firestore
          .collection(Paths.posts)
          .doc(post.postId)
          .set(post.toMap());
    } catch (error) {
      print('Error in creating post ${error.toString()}');
      throw const Failure(message: 'Error creating post');
    }
  }

  Future<List<Future<Post?>>> getOwnerPosts({required String? ownerId}) async {
    try {
      final ownerRef =
          FirebaseFirestore.instance.collection(Paths.users).doc(ownerId);
      final postsSnaps = await _firestore
          .collection(Paths.posts)
          // .withConverter<Post>(
          //     fromFirestore: (snapshot, _) => Post.fromMap(snapshot.data()!),
          //     toFirestore: (snapshtot, _) => snapshtot.toMap())
          .where('owner', isEqualTo: ownerRef)
          .get();

      return postsSnaps.docs.map((doc) => Post.fromDocument(doc)).toList();

      // return postsSnaps.docs.map((post) => post.data()).toList();
    } catch (error) {
      print('Error getting owner posts ${error.toString()}');
      throw const Failure(message: 'Error getting posts');
    }
  }

  @override
  Future<void> deletePost({required String? postId}) async {
    try {} catch (error) {
      if (postId != null) {
        await _firestore.collection(Paths.posts).doc(postId).delete();
        await FirebaseStorage.instance
            .ref()
            .child('postImages')
            .child(postId)
            .delete();
      }
    }
  }
}
