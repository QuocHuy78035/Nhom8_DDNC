import 'dart:convert';
import 'package:ddnangcao_project/api_service.dart';
import 'package:ddnangcao_project/features/food/controllers/i_food_controller.dart';
import 'package:ddnangcao_project/models/comment.dart';


class FoodController implements IFoodController{
  final ApiServiceImpl apiServiceImpl = ApiServiceImpl();
  @override
  Future<List<CommentModel>> getAllComment(String foodId) async{
    List<CommentModel> listComment = [];
    final response = await apiServiceImpl.get(url: "comment?food=$foodId");
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> listCommentResponse = data['metadata']['comments'];
      for (var comment in listCommentResponse) {
        listComment.add(CommentModel.fromJson(comment));
      }
    } else {
      throw Exception("Fail to get comment");
    }
    return listComment;
  }

  @override
  Future<bool> checkUserLikeCommentByCommentId(String commentId) async{
    late bool checkLiked;
    final response = await apiServiceImpl.get(url: "comment/$commentId/checkUserLiked");
    try{
      final Map<String, dynamic> data = jsonDecode(response.body);
      if(data['status'] == 200){
        checkLiked = data['metadata']['result'];
      }else{
        print("Fail to check user like comment");
      }
    }catch(e){
      throw Exception(e.toString());
    }return checkLiked;
  }

  @override
  Future<CommentModel> likedComment(String commentId) async {
    CommentModel comment;
    final response = await apiServiceImpl.patch(
      url: "comment/$commentId/like",
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    if (data['status'] == 200) {
      comment = data['metadata']['comment'];
    } else {
      throw Exception('Fail to add to like comment');
    }
    return comment;
  }

  @override
  Future<CommentModel> unLikedComment(String commentId) async{
    CommentModel comment;
    final response = await apiServiceImpl.patch(
      url: "comment/$commentId/unlike",
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    if (data['status'] == 200) {
      comment = data['metadata']['comment'];
    } else {
      throw Exception('Fail to add to unlike comment');
    }
    return comment;
  }
}