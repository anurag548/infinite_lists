import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({required this.id, required this.body, required this.title});

  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => [id, title, body];
}
