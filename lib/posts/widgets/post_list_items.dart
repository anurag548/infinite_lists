import 'package:flutter/material.dart';
import 'package:infinite_lists/posts/models/models.dart';

class PostListItems extends StatelessWidget {
  const PostListItems({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text(
          '${post.id}',
          style: textTheme.caption,
        ),
        title: Text(post.title),
        isThreeLine: true,
        dense: true,
        subtitle: Text(post.body),
      ),
    );
  }
}
