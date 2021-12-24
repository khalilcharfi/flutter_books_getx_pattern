import 'package:equatable/equatable.dart';

class BookDto extends Equatable {
  String? name;
  String? author;
  String? imageDir;

  BookDto({this.name, this.author, this.imageDir});

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        author,
        imageDir,
      ];
}
