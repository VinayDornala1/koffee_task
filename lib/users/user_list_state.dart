import '../models/user_model.dart';

abstract class UserListState {}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<User> users;
  final bool isLoadingMore;
  UserListLoaded(this.users, {this.isLoadingMore = false});
}

class UserListError extends UserListState {
  final String message;
  UserListError(this.message);
}
