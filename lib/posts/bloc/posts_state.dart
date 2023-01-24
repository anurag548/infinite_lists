part of 'posts_bloc.dart';

enum PostStatus { initial, success, failure }

class PostsState extends Equatable {
  const PostsState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  @override
  List get props => [status, posts, hasReachedMax];

  PostsState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      '''PostState{status:$status,hasReachedMax:$hasReachedMax posts: ${posts.length}} ''';
}
