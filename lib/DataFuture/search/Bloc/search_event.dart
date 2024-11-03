abstract class SearchEvent {}

final class SearchWithQueryData extends SearchEvent {
  final String query;
  String? id;
  SearchWithQueryData({required this.query, this.id});
}

final class SearchWithIdData extends SearchEvent {
  String id;
  SearchWithIdData({required this.id});
}
