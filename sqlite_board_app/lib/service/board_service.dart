
import 'package:sqlite_board_app/database_helper.dart';

class BoardService {

  // 데이터 목록
  Future<List<Map<String, dynamic>>> list() async {
    final db = await DatabaseHelper.instance.database;
    return await db.query('boards', orderBy: 'no DESC');
  }

  // 데이터 조회
  Future<Map<String, dynamic>?> get(int id) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('boards', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  // 데이터 등록
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('boards', data);
  }

  // 데이터 수정
  Future<int> update(int id, Map<String, dynamic> data) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update('boards', data, where: 'id = ?', whereArgs: [id]);
  }

  // 데이터 삭제
  Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete('boards', where: 'id = ?', whereArgs: [id]);
  }

}
