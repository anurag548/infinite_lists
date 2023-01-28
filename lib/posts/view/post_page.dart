import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_lists/app.dart';
import 'package:infinite_lists/posts/bloc/posts_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_lists/posts/view/post_view.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
          create: (_) =>
              PostsBloc(httpClient: http.Client())..add(PostFetched()),
          child: const PostsList()),
    );
  }
}
