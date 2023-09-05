import 'package:user_repository/user_repository.dart';

class PostEntity {
	String postId;
	String post;
	DateTime createAt;
	MyUser myUser;

	PostEntity({
		required this.postId,
		required this.post,
		required this.createAt,
		required this.myUser,
	});

	Map<String, Object?> toDocument() {
    return {
      'postId': postId,
			'post': post,
      'createAt': createAt,
      'myUser': myUser.toEntity().toDocument(),
    };
  }

	static PostEntity fromDocument(Map<String, dynamic> doc) {
    return PostEntity(
      postId: doc['postId'] as String,
			post: doc['post'] as String,
      createAt: DateTime.parse(doc['createAt']),
      myUser: MyUser.fromEntity(MyUserEntity.fromDocument(doc['myUser']))
    );
  }
	
	@override
	List<Object?> get props => [postId, post, createAt, myUser];

	@override
  String toString() {
    return '''PostEntity: {
      postId: $postId
      post: $post
      createAt: $createAt
      myUser: $myUser
    }''';
  }
}