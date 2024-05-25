abstract class SearchEvent {}

final class SearchWithQueryData extends SearchEvent {
  final String query;
  SearchWithQueryData({required this.query});
}
