part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}
abstract class PostsAction extends PostsState{}
final class PostsInitial extends PostsState {}
class PostsErrorState extends PostsState{}
class PostsLoadedState extends PostsState{
  final List<Posts> posts;
  PostsLoadedState({ required this.posts});
}
class PostClickedState extends PostsAction{
  final String chapter;
  final Posts post;
  PostClickedState({required this.chapter,required this.post});
}