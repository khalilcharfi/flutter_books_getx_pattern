/*
* this is a service that share data pre App like State Management of Data
* between 2 pages or more..etc
* */
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:interview/app/data/models/book.dart';

@lazySingleton
class BookService{
  var books = RxList<Book>();

}