import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interview/app/core/error/failures.dart';
import 'package:interview/app/data/datasources/local/repos/local_book_repo.dart';
import 'package:interview/app/data/models/book.dart';
import 'package:interview/app/data/models/dto/book_dto.dart';
import 'package:interview/app/data/repos/abstract/book_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import 'book_repo_test.mocks.dart';

@GenerateMocks([BookRepo])
void main() {
  late List<Book> tBooks;
  late Book tBook;
  late BookRepo bookRepo;
  late BookDto bookDto;
  const bookId = '29a86030-c5db-4811-b38d-a3555832ee75';

  setUp(() {
    bookRepo = MockBookRepo();
    bookDto = BookDto(
      name: 'new_name',
      author: 'new_author',
      imageDir: 'new_ImageDir',
    );
    tBook = Book(
      id: Uuid().v4(),
      name: 'book0',
      author: 'author0',
      imageDir: '/data/user/0/com.example.interview/cache/scaled_image_picker909846628989246183.jpg',
    );
    tBooks = [
      Book(
        id: Uuid().v4(),
        name: 'book1',
        author: 'author1',
        imageDir: '/data/user/0/com.example.interview/cache/scaled_image_picker909846628989246183.jpg',
      ),
      Book(
        id: Uuid().v4(),
        name: 'book2',
        author: 'author2',
        imageDir: '/data/user/0/com.example.interview/cache/scaled_image_picker2568283938689079410.jpg',
      ),
      Book(
        id: Uuid().v4(),
        name: 'book3',
        author: 'author3',
        imageDir: '/data/user/0/com.example.interview/cache/scaled_image_picker6585340774041969729.jpg',
      ),
      Book(
        id: Uuid().v4(),
        name: 'book4',
        author: 'author4',
        imageDir: '/data/user/0/com.example.interview/cache/scaled_image_picker157298307745771520.jpg',
      )
    ];
  });

  group('book_repo_test', () {
    group('addBook', () {
      Future<Either<Failure, Book>> fun() {
        return bookRepo.addBook(bookDto: bookDto);
      }

      test('should return [Right(Book)] when a book is saved [success]', () async {
        when(
          bookRepo.addBook(bookDto: bookDto),
        ).thenAnswer((_) async => Right(tBook));

        // ACT
        final result = await fun();
        // ASSERT
        verify(bookRepo.addBook(bookDto: bookDto));

        expect(result, Right(tBook));
      });

      test('should return [Left(CacheFailure)] when a book is not saved [failure]', () async {
        when(
          bookRepo.addBook(bookDto: bookDto),
        ).thenAnswer((_) async => Left(CacheFailure()));

        // ACT
        final result = await fun();
        // ASSERT
        verify(bookRepo.addBook(bookDto: bookDto));

        expect(result, Left(CacheFailure()));
      });
    });

    group('getBooks', () {
      Future<Either<Failure, List<Book>>> fun() {
        return bookRepo.getBooks();
      }

      test('should return [Right(Books)] when  books exist on local [success]', () async {
        when(
          bookRepo.getBooks(),
        ).thenAnswer((_) async => Right(tBooks));

        // ACT
        final result = await fun();
        // ASSERT
        verify(bookRepo.getBooks());

        expect(result, Right(tBooks));
      });

      test('should return [Left(CacheFailure)] when there is issue with local', () async {
        when(
          bookRepo.getBooks(),
        ).thenAnswer((_) async => Left(CacheFailure()));

        // ACT
        final result = await fun();
        // ASSERT
        verify(bookRepo.getBooks());

        expect(result, Left(CacheFailure()));
      });
    });

    group('editBook', () {
      Future<Either<Failure, Book>> fun() {
        return bookRepo.editBook(bookDto: bookDto, bookId: bookId);
      }

      test('should return [Right(Book)] when a the book is edited [success]', () async {
        when(
          bookRepo.editBook(bookDto: bookDto, bookId: bookId),
        ).thenAnswer((_) async => Right(tBook));

        // ACT
        final result = await fun();
        // ASSERT
        verify(bookRepo.editBook(bookDto: bookDto, bookId: bookId));

        expect(result, Right(tBook));
      });

      test('should return [Left(CacheFailure)] when a book cant be edited  [failure]', () async {
        when(
          bookRepo.editBook(bookDto: bookDto, bookId: bookId),
        ).thenAnswer((_) async => Left(CacheFailure()));

        // ACT
        final result = await fun();
        // ASSERT
        verify(bookRepo.editBook(bookDto: bookDto, bookId: bookId));

        expect(result, Left(CacheFailure()));
      });
    });

    group('getBook', () {
      Future<Either<Failure, Book>> fun() {
        return bookRepo.getBook(bookId: bookId);
      }

      test('should return [Right(Book)] when a book exist on local [success]', () async {
        when(
          bookRepo.getBook(bookId: bookId),
        ).thenAnswer((_) async => Right(tBook));

        // ACT
        final result = await fun();
        // ASSERT
        verify(bookRepo.getBook(bookId: bookId));

        expect(result, Right(tBook));
      });

      test('should return [Left(CacheFailure)] when a book is not exist on local [failure]', () async {
        when(
          bookRepo.getBook(bookId: bookId),
        ).thenAnswer((_) async => Left(CacheFailure()));

        // ACT
        final result = await fun();
        // ASSERT
        verify(bookRepo.getBook(bookId: bookId));

        expect(result, Left(CacheFailure()));
      });
    });

    group('deleteBook', () {
      Future<Either<Failure, bool>> fun() {
        return bookRepo.deleteBook(bookId: bookId);
      }

      test('should return [Right(true)] when a book deleted on local [success]', () async {
        when(
          bookRepo.deleteBook(bookId: bookId),
        ).thenAnswer((_) async => Right(true));

        // ACT
        final result = await fun();
        // ASSERT
        verify(bookRepo.deleteBook(bookId: bookId));

        expect(result, Right(true));
      });



      test('should return [Left(CacheFailure)] when the book is not exist on local Or cant be deleted [failure]', () async {
        when(
          bookRepo.deleteBook(bookId: bookId),
        ).thenAnswer((_) async => Left(CacheFailure()));

        // ACT
        final result = await fun();
        // ASSERT
        verify(bookRepo.deleteBook(bookId: bookId));

        expect(result, Left(CacheFailure()));
      });
    });
  });
}
