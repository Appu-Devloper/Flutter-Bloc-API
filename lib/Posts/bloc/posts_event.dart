part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}
class InitialPostEvent extends PostsEvent{
  final String Chapterid;
  InitialPostEvent({required this.Chapterid});
}
class PostsNavigation extends PostsEvent{
 final String chapter;
  final Posts post;
  PostsNavigation({required this.post,required this.chapter});
}