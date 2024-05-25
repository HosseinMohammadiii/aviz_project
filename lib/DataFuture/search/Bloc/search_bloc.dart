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
        final result = await searchRepository.search(event.query);
        emit(
          SearchRequestSuccessState(result),
        );
      },
    );
  }
}
