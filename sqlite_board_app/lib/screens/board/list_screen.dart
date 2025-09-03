import 'package:flutter/material.dart';
import 'package:sqlite_board_app/models/boards.dart';
import 'package:sqlite_board_app/service/board_service.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // 🧊 state
  late Future<List<Map<String, dynamic>>> _boardList;
  final boardService = BoardService();

  @override
  void initState() {
    super.initState();
    // 게시글 목록 요청
    _boardList = boardService.list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("게시글 목록")),
      body: 
        Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
          child: 
            FutureBuilder(
              future: _boardList,     // 비동기 데이터 
              builder: (context, snapshot) {
                // 데이터 로딩 중
                if( snapshot.connectionState == ConnectionState.waiting ) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                // 에러 발생
                else if( snapshot.hasError ) {
                  return Column(
                    children: [
                      Center(child: Text("데이터 조회 시, 에러"),),
                      Center(child: Text('Error: ${snapshot.error}'),),
                    ],
                  );
                }
                // 데이터 없음
                else if( !snapshot.hasError && snapshot.data!.isEmpty ) {
                  return const Center(child: Text("조회된 데이터가 없습니다."),);
                }
                // 데이터 있음
                else {
                  List<Map<String, dynamic>> boardData = snapshot.data!;
                  return ListView.builder(
                    itemCount: boardData.length,
                    itemBuilder: (context, index) {
                      final board = Boards.fromMap(boardData[index]);
                      return Card(
                        child: ListTile(
                            title: Text(board.title ?? ''),
                            subtitle: Text(board.content ?? ''),
                          ),
                      );
                    }
                  );
                }
              }
            )
        )
    );


  }
}