part of 'explorer_cubit.dart';

class ExplorerState {
  final List<DataPostingModel>? listDataExplorerModel;

  ExplorerState({this.listDataExplorerModel});

  ExplorerState copyWith({
    List<DataPostingModel>? listDataExplorerModel,
  }) {
    return ExplorerState(
      listDataExplorerModel:
          listDataExplorerModel ?? this.listDataExplorerModel,
    );
  }
}

class ExplorerInitial extends ExplorerState {}

class ExplorerLoading extends ExplorerState {}

class LikesLoading extends ExplorerState {}
