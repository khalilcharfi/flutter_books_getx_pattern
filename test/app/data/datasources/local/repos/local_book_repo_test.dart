import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:interview/app/core/error/exceptions.dart';
import 'package:interview/app/data/datasources/local/repos/local_book_repo.dart';
import 'package:interview/app/data/models/book.dart';
import 'package:interview/app/data/models/dto/book_dto.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import 'local_book_repo_test.mocks.dart';

@GenerateMocks([LocalBookRepo])
main() {
  late List<Book> tBooks;
  late LocalBookRepo localBookRepo;
  const bookBoxKey = 'book_box_key';
  late BookDto bookDto;
  late Book tBook;
  const bookId = '29a86030-c5db-4811-b38d-a3555832ee75';

  setUp(() {
    bookDto = BookDto(
      name: 'new_name',
      author: 'new_author',
      imageDir: 'new_ImageDir',
    );

    localBookRepo = MockLocalBookRepo();
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

  group('local_book_repo', () {
    group('getBooks', () {
      Future<List<Book>> fun() {
        return localBookRepo.getBooks(
        );
      }

      test('should return [List<Book>] when a books is exists [success]', () async {
        //arrange
        when(
          localBookRepo.getBooks(),
        ).thenAnswer((_) async => tBooks);

        //act
        final result = await fun();
        //assert
        verify(localBookRepo.getBooks());

        expect(result, tBooks);
      });

      test('should throw [CacheException] when a there is issue fetching books from local [failure]', () async {
        //arrange
        when(
          localBookRepo.getBooks(),
        ).thenAnswer((_) async =>  throw CacheException());

        //act
        final call =  fun();
        //assert
        verify(localBookRepo.getBooks());

        expect(call, throwsA(isA<CacheException>()));
      });
    });
    group('addBook', () {
      Future<Book> fun() {
        return localBookRepo.addBook(
          bookDto: bookDto,
        );
      }

      test('should return [Book] when a book is saved [success]', () async {
        //arrange
        when(
          localBookRepo.addBook(bookDto: bookDto),
        ).thenAnswer((_) async => tBook);

        //act
        final result = await fun();
        //assert
        verify(localBookRepo.addBook(bookDto: bookDto));

        expect(result, tBook);
      });

      test('should throw [CacheException] when a book is not saved [failure]', () async {
        //arrange
        when(
          localBookRepo.addBook(bookDto: bookDto),
        ).thenAnswer((_) async =>  throw CacheException());

        //act
        final call =  fun();
        //assert
        verify(localBookRepo.addBook(bookDto: bookDto));

        expect(call, throwsA(isA<CacheException>()));
      });
    });
    group('getBook', () {
      Future<Book> fun() {
        return localBookRepo.getBook(
          bookId: bookId,
        );
      }

      test('should return [Book] when a book is exist [success]', () async {
        //arrange
        when(
          localBookRepo.getBook(bookId: bookId),
        ).thenAnswer((_) async => tBook);

        //act
        final result = await fun();
        //assert
        verify(localBookRepo.getBook(bookId: bookId));

        expect(result, tBook);
      });

      test('should throw [CacheException] when a book is not exist [failure]', () async {
        //arrange
        when(
          localBookRepo.getBook(bookId: bookId),
        ).thenAnswer((_) async =>  throw CacheException());

        //act
        final call =  fun();
        //assert
        verify(localBookRepo.getBook(bookId: bookId));

        expect(call, throwsA(isA<CacheException>()));
      });
    });
    group('deleteBook', () {
      Future<bool> fun() {
        return localBookRepo.deleteBook(
          bookId: bookId,
        );
      }

      test('should return [true] when a book is deleted [success]', () async {
        //arrange
        when(
          localBookRepo.deleteBook(bookId: bookId),
        ).thenAnswer((_) async => true);

        //act
        final result = await fun();
        //assert
        verify(localBookRepo.deleteBook(bookId: bookId));

        expect(result, true);
      });

      test('should throw [CacheException] when a book is not deleted [failure]', () async {
        //arrange
        when(
          localBookRepo.deleteBook(bookId: bookId),
        ).thenAnswer((_) async =>  throw CacheException());

        //act
        final call =  fun();
        //assert
        verify(localBookRepo.deleteBook(bookId: bookId));

        expect(call, throwsA(isA<CacheException>()));
      });
    });
    group('editBook', () {
      Future<Book> fun() {
        return localBookRepo.editBook(
          bookId: bookId,
          bookDto: bookDto,
        );
      }

      test('should return [book] when a book is eidted [success]', () async {
        //arrange
        when(
          localBookRepo.editBook( bookId: bookId,
            bookDto: bookDto,),
        ).thenAnswer((_) async => tBook);

        //act
        final result = await fun();
        //assert
        verify(localBookRepo.editBook(bookId: bookId, bookDto: bookDto));

        expect(result, tBook);
      });

      test('should throw [CacheException] when a book is not edited [failure]', () async {
        //arrange
        when(
          localBookRepo.editBook(bookId: bookId, bookDto: bookDto),
        ).thenAnswer((_) async =>  throw CacheException());

        //act
        final call =  fun();
        //assert
        verify(localBookRepo.editBook(bookId: bookId, bookDto: bookDto));

        expect(call, throwsA(isA<CacheException>()));
      });
    });
  });
}
