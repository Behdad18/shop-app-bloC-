part of 'comment_list_bloc.dart';

sealed class CommentListState extends Equatable {
  const CommentListState();

  @override
  List<Object> get props => [];
}

final class CommentListLoading extends CommentListState {}

class CommentListSuccess extends CommentListState {
  final List<CommentEntity> comments;

  const CommentListSuccess({required this.comments});

  @override
  List<Object> get props => [comments];
}

class CommentListError extends CommentListState{
  final AppExceotions exceotions;

  const CommentListError({required this.exceotions});
  @override
  // TODO: implement props
  List<Object> get props => [exceotions];
}