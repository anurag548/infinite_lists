import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_lists/posts/models/models.dart';
import 'package:http/http.dart' as http;
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final http.Client httpClient;
  PostsBloc({required this.httpClient}) : super(const PostsState()) {
    on<PostFetched>(_onPostFetched);
  }

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostsState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(state.copyWith(
          hasReachedMax: false,
          status: PostStatus.success,
          posts: posts,
        ));
      }
      final posts = await _fetchPosts(state.posts.length);
      emit(
        posts.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
              ),
      );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
