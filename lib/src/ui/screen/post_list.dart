import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lotalk_frontend/src/model/detail_post.dart';

import 'package:lotalk_frontend/src/model/post.dart';
import 'package:lotalk_frontend/src/repository/post_repository.dart';
import 'package:lotalk_frontend/src/ui/screen/post_create_page.dart';
import 'package:lotalk_frontend/src/ui/screen/post_detail.dart';

class PostList extends StatefulWidget {
  const PostList({required this.repository, Key? key}) : super(key: key);

  final PostRepository repository;

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  PostRepository get _repository => widget.repository;

  final _pagingController = PagingController<int, Post>(firstPageKey: 0);

  get detail => null;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newPage = await _repository.getPosts(page: pageKey);

      if (newPage.last) {
        _pagingController.appendLastPage(newPage.content);
      } else {
        _pagingController.appendPage(newPage.content, pageKey + 1);
      }
    } catch (e) {
      print('fetch error: $e');
      _pagingController.error = e;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  postCard({
    required Post post,
  }) {
    return Card(
      child: ListTile(
        title: Text('${post.title}   (${post.view})'),
        subtitle: Text(post.writer),
        onTap: () {
          _moveToDetailPage(post);
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('게시판'),
    ),
    body: RefreshIndicator(
      onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
      ),
      child: PagedListView.separated(
        pagingController: _pagingController,
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        builderDelegate: PagedChildBuilderDelegate<Post>(
          itemBuilder: (_, post, index) => postCard(post: post),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        _moveToCreatePage();
      },
      child: Icon(Icons.add),
    ),
  );
  
  void _moveToDetailPage(Post post){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PostDetail(postId: post.id, repository: PostRepository.instance)));
  }

  void _moveToCreatePage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PostCreatePage(repository: PostRepository.instance)));
  }
}
