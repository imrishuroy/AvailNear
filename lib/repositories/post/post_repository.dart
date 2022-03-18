import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/failure.dart';
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

  @override
  Future<List<Future<Post?>>> getRenterPosts() async {
    try {
      final postsSnaps = await _firestore
          .collection(Paths.posts)
          .orderBy('createdAt', descending: true)
          .get();

      return postsSnaps.docs.map((doc) => Post.fromDocument(doc)).toList();
    } catch (error) {
      print('Error in getting renter posts -- ${error.toString()}');
      throw const Failure(message: 'Error in getting posts');
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
          .orderBy('createdAt', descending: true)
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

  Future<void> wishlistPost({
    required String? postId,
    required String? userId,
  }) async {
    try {
      if (postId == null || userId == null) {
        return;
      }

      await _firestore
          .collection(Paths.wishlist)
          .doc(userId)
          .collection(Paths.userWishlists)
          .doc(postId)
          .set(
        {
          //  'post': _firestore.collection(Paths.posts).doc(postId),
          'date': Timestamp.fromDate(DateTime.now())
        },
      );
      // await _firestore
      //     .collection(Paths.wishlist)
      //     .doc(postId)
      //     .collection(Paths.userWishlists)
      //     .doc(userId)
      //     .set({'post': _firestore.collection(Paths.posts).doc(postId)});
    } catch (error) {
      print('Error in wishlist post ${error.toString()}');
      throw const Failure(message: 'Error in wishliting post');
    }
  }

  Future<void> deletedWishlist({
    required String? postId,
    required String? userId,
  }) async {
    try {
      if (postId == null || userId == null) {
        return;
      }
      await _firestore
          .collection(Paths.wishlist)
          .doc(userId)
          .collection(Paths.userWishlists)
          .doc(postId)
          .delete();
    } catch (error) {
      print('Error in deleting wishlist ${error.toString()}');
    }
  }

  Future<Set<String>> getWishListPostIds({
    required String? userId,
    // required List<Post?>? posts,
  }) async {
    if (userId == null) {
      return {};
    }

    //  var postIds = <String>{};

    final wishListSnaps = await _firestore
        .collection(Paths.wishlist)
        .doc(userId)
        .collection(Paths.userWishlists)
        //.orderBy('date', descending: true)
        .get();

    // postIds =

    return wishListSnaps.docs.map((doc) => doc.id).toSet();

    // for (final post in posts) {
    //   final likeDoc = await _firestore
    //       .collection(Paths.wishlist)
    //       .doc(post?.postId)
    //       .collection(Paths.userWishlists)
    //       .doc(userId)
    //       .get();
    //   if (likeDoc.exists) {
    //     postIds.add(post!.postId!);
    //   }
    // }
    // return postIds;

//    return postIds;
  }

  Future<List<Future<Post?>>> getWishListPosts({
    required String? userId,
  }) async {
    try {
      final wishListSnaps = await _firestore
          .collection(Paths.wishlist)
          .doc(userId)
          .collection(Paths.userWishlists)
          .orderBy('date', descending: true)
          .get();

      return wishListSnaps.docs.map((doc) async {
        final postRef = _firestore.collection(Paths.posts).doc(doc.id);
        return Post.fromDocument(await postRef.get());
      }).toList();
    } catch (error) {
      print('Error get wishlist items ${error.toString()}');
      throw const Failure(message: 'Error in wishlists items ');
    }
  }
}
