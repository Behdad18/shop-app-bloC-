import 'package:app/data/comment.dart';
import 'package:app/data/repository/comment_repository.dart';
import 'package:app/ui/product/comment/bloc/comment_list_bloc.dart';
import 'package:app/ui/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentList extends StatelessWidget {
  final int productId;
  const CommentList({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentListBloc bloc = CommentListBloc(
          repository: commentRepository,
          productId: productId,
        );
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListSuccess) {
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return CommentItem(data: state.comments[index]);
              }, childCount: state.comments.length),
            );
          } else if (state is CommentListLoading) {
            return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is CommentListError) {
            return SliverToBoxAdapter(
              child: AppErrorWidget(
                exception: state.exceotions,
                onPressed: () {
                  BlocProvider.of<CommentListBloc>(
                    context,
                  ).add(CommentListStarted());
                },
              ),
            );
          } else {
            throw Exception('state is not supported');
          }
        },
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommentEntity data;
  const CommentItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerColor),borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(data.title),
                SizedBox(height: 4,),
                 Text(data.email)],
              ),
              Text(data.data,style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
          Text(data.content),
        ],
      ),
    );
  }
}
