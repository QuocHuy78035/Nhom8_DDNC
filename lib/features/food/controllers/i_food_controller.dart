import 'package:ddnangcao_project/models/comment.dart';

abstract class IFoodController{
  Future<List<CommentModel>> getAllComment(String foodId);
  Future<bool> checkUserLikeCommentByCommentId(String commentId);
  Future<CommentModel> likedComment(String commentId);
  Future<CommentModel> unLikedComment(String commentId);
}