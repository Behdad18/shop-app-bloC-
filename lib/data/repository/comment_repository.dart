import 'package:app/common/http_client.dart';
import 'package:app/data/comment.dart';
import 'package:app/data/data_source/comment_data_source.dart';

final commentRepository = CommentRepository(
  dataSource: CommentRemoteDataSource(httpClient: httpClient),
);

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository({required this.dataSource});
  @override
  Future<List<CommentEntity>> getAll({required int productId}) =>
      dataSource.getAll(productId: productId);
}
