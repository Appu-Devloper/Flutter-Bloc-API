import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../Models/chapterdatamodel.dart';

part 'chapter_event.dart';
part 'chapter_state.dart';

class ChapterBloc extends Bloc<ChapterEvent, ChapterState> {
  ChapterBloc() : super(ChapterInitial()) {
    on<ChapterInitialEvent>(_chapterinitalevent);
    on<ChapterNavigationEvent>(_chapternavigationevent);
  }

  FutureOr<void> _chapterinitalevent(
      ChapterInitialEvent event, Emitter<ChapterState> emit) async {
        emit(ChapterLoading());
    var client = http.Client();
    List<BhagavadGitaChapter> _chapters = [];
    try {
      var response =
          await client.get(Uri.parse("https://bhagavadgitaapi.in/chapters"));
     List data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        BhagavadGitaChapter mychapter = BhagavadGitaChapter.fromJson(data[i] as Map<String,dynamic>);
        _chapters.add(mychapter);
      }
      //print(_chapters);
      emit(ChapterLoadedState(chapters: _chapters));
    } catch (e) {
      //print(e);
      emit(Chaptererror());
      client.close();
    }
  }

  FutureOr<void> _chapternavigationevent(ChapterNavigationEvent event, Emitter<ChapterState> emit) {
    //print("CLicked");
    emit(ChapterClickedState(Chapter_id:event.chapter_id, chapter: event.chapter));
  }
}
