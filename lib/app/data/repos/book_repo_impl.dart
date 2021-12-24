import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:interview/app/core/error/exceptions.dart';
import 'package:interview/app/core/error/failures.dart';
import 'package:interview/app/data/datasources/local/repos/local_book_repo.dart';
import 'package:interview/app/data/models/book.dart';
import 'package:interview/app/data/models/dto/book_dto.dart';
import 'package:interview/app/data/repos/abstract/book_repo.dart';

/// [MUST READ]
/// this layer is when we decide to choose what datasource we use
/// in project when there is API we will test on connectivity and then chose
/// [remoteBookRepo] as source or [localBookRepo] if there is no internet
@Injectable(as: BookRepo)
class BookRepoImpl implements BookRepo {
  //NetworkInfo networkInfo;
  //RemoteBookRepo remoteBookRepo;
  LocalBookRepo localBookRepo;

  BookRepoImpl(this.localBookRepo);

  @override
  Future<Either<Failure, Book>> addBook({required BookDto bookDto}) async {
    try {
      final book = await localBookRepo.addBook(bookDto: bookDto);
      return Right(book);
    } on CacheException catch (cacheException) {
      /// in reality here we should add FireBase Crashlytics to log this
      return Left(CacheFailure(message: cacheException.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteBook({required String bookId}) async {
    try {
      final isDone = await localBookRepo.deleteBook(bookId: bookId);
      return Right(isDone);
    } on CacheException catch (cacheException) {
      /// in reality here we should add FireBase Crashlytics to log this
      return Left(CacheFailure(message: cacheException.message));
    }
  }

  @override
  Future<Either<Failure, Book>> editBook({required String bookId, required BookDto bookDto}) async {
    try {
      final book = await localBookRepo.editBook(bookId: bookId, bookDto: bookDto);
      return Right(book);
    } on CacheException catch (cacheException) {
      /// in reality here we should add FireBase Crashlytics to log this
      return Left(CacheFailure(message: cacheException.message));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    try {
      final books = await localBookRepo.getBooks();
      return Right(books);
    } on CacheException catch (cacheException) {
      /// in reality here we should add FireBase Crashlytics to log this
      return Left(CacheFailure(message: cacheException.message));
    }
  }

  @override
  Future<Either<Failure, Book>> getBook({required String bookId}) async {
    try {
      final book = await localBookRepo.getBook(bookId: bookId);
      return Right(book);
    } on CacheException catch (cacheException) {
      /// in reality here we should add FireBase Crashlytics to log this
      return Left(CacheFailure(message: cacheException.message));
    }
  }
}
