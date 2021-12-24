import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:interview/app/core/error/exceptions.dart';
import 'package:interview/app/data/datasources/local/hive_constant.dart';
import 'package:interview/app/data/models/book.dart';
import 'package:interview/app/data/models/dto/book_dto.dart';
import 'package:interview/generated/locales.g.dart';
import 'package:uuid/uuid.dart';

abstract class LocalBookRepo {
  Future<Book> addBook({required BookDto bookDto});

  Future<Book> getBook({required String bookId});

  Future<bool> deleteBook({required String bookId});

  Future<Book> editBook({required String bookId, required BookDto bookDto});

  Future<List<Book>> getBooks();
}

@Injectable(as: LocalBookRepo)
class LocalBookRepoImpl implements LocalBookRepo {
  
  HiveInterface hive;
  
  LocalBookRepoImpl({required this.hive});

  Future<Box<Book>> _getBox() async {
    Box<Book> box = hive.isBoxOpen(bookBoxKey) ? hive.box<Book>(bookBoxKey) : await hive.openBox<Book>(bookBoxKey);
    return box;
  }

  @override
  Future<Book> addBook({required BookDto bookDto}) async {
    try {
      final box = await _getBox();
      final newBook = Book(
        id: Uuid().v4(),
        name: bookDto.name,
        author: bookDto.author,
        imageDir: bookDto.imageDir,
      );
      print('book date=${newBook.updatedAt}');
      await box.put(newBook.id, newBook);
      final createdBook = box.get(newBook.id);
      await _closeBox();

      if (createdBook == null) throw Exception();
      return createdBook;
    } catch (e) {
      const log = 'add Book Failed';
      throw CacheException(message: log);
    }
  }

  @override
  Future<bool> deleteBook({required String bookId}) async {
    try {
      final box = await _getBox();
      box.get(bookId);
      final founded = await getBook(bookId: bookId);
      await box.delete(founded.id);
      _closeBox();
      return true;
    } catch (e) {
      throw CacheException(message: LocaleKeys.book_not_found.tr);
    }
  }

  @override
  Future<Book> editBook({required String bookId, required BookDto bookDto}) async {
    try {
      final box = await _getBox();
      final book = await getBook(bookId: bookId);
      if (bookDto.name != null) book.name = bookDto.name;
      if (bookDto.author != null) book.author = bookDto.author;
      if (bookDto.imageDir != null) book.imageDir = bookDto.imageDir;
      book.updatedAt=DateTime.now();

      print('book date=${book.updatedAt}');
      await box.put(book.id, book);
      final createdBook = box.get(book.id);
      await _closeBox();

      if (createdBook == null) throw Exception();
      return createdBook;
    } catch (e) {
      throw CacheException(message: LocaleKeys.edit_failure.tr);
    }
  }

  @override
  Future<List<Book>> getBooks() async {
    try {
      final box = await _getBox();
      if (box.isEmpty) return [];

      var books = box.values;
      List<Book> orderedList = [];
      orderedList = _orderBookByUpdatedAt(
        list: books.toList(),
      );

      // Take Only A Limit
      //if (filter?.limit != null) return orderedList.take(filter!.limit!).toList();
      await _closeBox();
      return orderedList;
    } catch (e) {
      throw CacheException();
    }
  }

  _closeBox() async {
    if (hive.isBoxOpen(bookBoxKey)) await hive.box<Book>(bookBoxKey).close();
  }

  List<Book> _orderBookByUpdatedAt({required List<Book> list, bool asc = false}) {
    int rev = asc ? 1 : -1;
    list.sort((a, b) => rev * (a.updatedAt.compareTo(b.updatedAt)));

    return list.toList();
  }

  @override
  Future<Book> getBook({required String bookId}) async {
    try {
      final box = await _getBox();
      final founded = box.get(bookId);
      if (founded == null) throw Exception();
      return founded;
    } catch (e) {
      throw CacheException(message: LocaleKeys.book_not_found.tr);
    }
  }
}
