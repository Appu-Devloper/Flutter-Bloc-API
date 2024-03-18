part of 'chapter_bloc.dart';

@immutable
abstract class ChapterEvent {}
class ChapterInitialEvent extends ChapterEvent{}
class ChapterNavigationEvent extends ChapterEvent{
  final String chapter_id;
  final String chapter;
  ChapterNavigationEvent({required this.chapter_id,required this.chapter});
}

