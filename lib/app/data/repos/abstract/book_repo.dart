import 'package:dartz/dartz.dart';
import 'package:interview/app/core/error/failures.dart';
import 'package:interview/app/data/models/book.dart';
import 'package:interview/app/data/models/dto/book_dto.dart';

abstract class BookRepo {
  Future<Either<Failure, List<Book>>> getBooks();

  Future<Either<Failure, Book>> addBook({required BookDto bookDto});

  Future<Either<Failure, Book>> editBook({required String bookId, required BookDto bookDto});

  Future<Either<Failure, Book>> getBook({required String bookId});

  Future<Either<Failure, bool>> deleteBook({required String bookId});
}
