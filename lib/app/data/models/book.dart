import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'book.g.dart';


@HiveType(typeId: 1)
class Book with EquatableMixin {
  @HiveField(0)
  String id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? author;

  @HiveField(3)
  String? imageDir;

  @HiveField(4)
  DateTime updatedAt = DateTime.now();


  Book({
    required this.id,
    this.name,
    this.author,
    this.imageDir,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}
