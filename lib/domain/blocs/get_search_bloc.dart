import 'package:news_cleaan_arch_bloc/domain/bloc_models/bloc_search_models.dart';
import 'package:news_cleaan_arch_bloc/domain/model/article_response.dart';
import 'package:news_cleaan_arch_bloc/domain/repository/news_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetSearchBloc {
  NewsRepository _newsRepository;
  final BehaviorSubject<ArticleResponseModel> _subject =
      BehaviorSubject<ArticleResponseModel>();
  GetSearchBloc(this._newsRepository);

  ArticleResponseModel get defaultitem => SearchModelInitState();
  BehaviorSubject<ArticleResponseModel> get subject => _subject;

  void loadSearchModel(String value) async {
    _subject.sink.add(SearchModelLoadingState());
    var searchModel;
    try {
      searchModel = await _newsRepository.search(value: value);
    } catch (errorS) {
      _subject.sink.add(SearchModelErrorState(error: errorS.toString()));
    }
    if (searchModel != null) {
      _subject.sink.add(SearchModelOKState(model: searchModel));
    } else {
      _subject.sink.add(SearchModelErrorState(error: "Ошибка"));
    }
  }

  dispose() {
    _subject.close();
  }
}
