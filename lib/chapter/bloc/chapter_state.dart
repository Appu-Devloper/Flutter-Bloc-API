part of 'chapter_bloc.dart';

@immutable
abstract class ChapterState {}
abstract class ChapterAction extends ChapterState{}
class ChapterClickedState extends ChapterAction{
  final Chapter_id;
  final chapter;
  ChapterClickedState({required this.Chapter_id,required this.chapter});
}
final class ChapterInitial extends ChapterState {}
class ChapterLoading extends ChapterState{

}
class ChapterLoadedState extends ChapterState{
  final List<BhagavadGitaChapter> chapters;
  ChapterLoadedState({required this.chapters});
}
class Chaptererror extends ChapterState{}