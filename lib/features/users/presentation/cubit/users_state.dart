part of 'users_cubit.dart';

class UsersState {
  final List<Owner>? listOwner;

  UsersState({this.listOwner});

  UsersState copyWith({
    List<Owner>? listOwner,
  }) {
    return UsersState(
      listOwner: listOwner ?? this.listOwner,
    );
  }
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}
