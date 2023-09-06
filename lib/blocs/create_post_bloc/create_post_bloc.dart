import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
	PostRepository _postRepository;

  CreatePostBloc({
		required PostRepository postRepository
	}) : _postRepository = postRepository,
		super(CreatePostInitial()) {
    on<CreatePost>((event, emit) async {
			emit(CreatePostLoading());
      try {
				Post post = await _postRepository.createPost(event.post);
        emit(CreatePostSuccess(post));
      } catch (e) {
        emit(CreatePostFailure());
      }
    });
  }
}
