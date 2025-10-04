import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/user_repository.dart';
import '../models/user_model.dart';
import 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  final UserRepository repository;
  int _currentPage = 1;
  bool _hasMore = true;
  List<User> _users = [];
  static const int _limit = 10;

  UserListCubit(this.repository) : super(UserListInitial());

  bool get hasMore => _hasMore;

  Future<void> fetchUsers({bool isLoadMore = false}) async {
    if (state is UserListLoading && !isLoadMore) return;
    if (!_hasMore && isLoadMore) return;

    if (!isLoadMore) {
      _currentPage = 1;
      _users = [];
      _hasMore = true;
      emit(UserListLoading());
    } else {
      emit(UserListLoaded(_users, isLoadingMore: true));
    }

    try {
      final response = await repository.fetchUsers(limit: _limit, page: _currentPage);
      final newUsers = response.data.users;
      if (newUsers.length < _limit) _hasMore = false;
      _users.addAll(newUsers);
      emit(UserListLoaded(_users, isLoadingMore: false));
      _currentPage++;
    } catch (e) {
      emit(UserListError(e.toString()));
    }
  }
  Future<void> deleteUser(int userId) async {
    try {
     var response = await repository.deleteUser(userId);
     if (response.statusCode == 200) {
        _users.removeWhere((user) => user.id == userId);
        emit(UserListLoaded(List.from(_users)));
      } else {
        emit(UserListError('Failed to delete user'));
      }
    } catch (e) {
      emit(UserListError(e.toString()));
    }
  }
}
