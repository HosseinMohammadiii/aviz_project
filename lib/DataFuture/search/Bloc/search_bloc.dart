import 'package:aviz_project/DataFuture/search/Bloc/search_event.dart';
import 'package:aviz_project/DataFuture/search/Bloc/search_state.dart';
import 'package:aviz_project/DataFuture/search/Data/repository/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ISearchRepository searchRepository;
  SearchBloc(this.searchRepository) : super(SearchInitialState()) {
    on<SearchWithQueryData>(
      (event, emit) async {
        emit(SearchLoadingState());
        var searchResult = await searchRepository.search(event.query);
        var adFacilities = await searchRepository.adFacilities();

        emit(SearchRequestSuccessState(
          searchResult,
          adFacilities,
        ));
      },
    );
  }
}

class AdExistsBloc extends Bloc<SearchEvent, SearchState> {
  final ISearchRepository searchRepository;
  AdExistsBloc(this.searchRepository) : super(SearchInitialState()) {
    on<SearchWithIdData>(
      (event, emit) async {
        emit(SearchLoadingState());
        var getExist = await searchRepository.getExistsAd(event.id ?? '');

        emit(SearchExistsRequestSuccessState(
          getExist,
        ));
      },
    );
  }
}
