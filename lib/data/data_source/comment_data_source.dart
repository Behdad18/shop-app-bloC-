import 'package:app/common/http_response_validatore.dart';
import 'package:app/data/comment.dart';
import 'package:dio/dio.dart';

abstract class ICommentDataSource {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRemoteDataSource
    with HttpResponseValidatore
    implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource({required this.httpClient});
  @override
  Future<List<CommentEntity>> getAll({required int productId}) async {
    final response = await httpClient.get('comment/list?product_id=$productId');
    validateRespone(response);
    final List<CommentEntity> comments = [];
    (response.data as List).forEach((element) {
      comments.add(CommentEntity.fromJson(element));
    });
    return comments;
  }
}
