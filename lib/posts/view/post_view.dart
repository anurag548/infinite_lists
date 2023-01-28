import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_lists/posts/bloc/posts_bloc.dart';
import 'package:infinite_lists/posts/widgets/bottom_loader.dart';
import 'package:infinite_lists/posts/widgets/post_list_items.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PostsBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    // F
    return _scrollController.offset >=
        (_scrollController.position.maxScrollExtent * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(builder: ((context, state) {
      switch (state.status) {
        case PostStatus.failure:
          return const Center(
            child: Text('failed to fetch posts'),
          );
        case PostStatus.success:
          if (state.posts.isEmpty) {
            return const Center();
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return index >= state.posts.length
                  ? const BottomLoader()
                  : PostListItems(post: state.posts[index]);
            },
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            controller: _scrollController,
          );

        case PostStatus.initial:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    }));
  }
}
