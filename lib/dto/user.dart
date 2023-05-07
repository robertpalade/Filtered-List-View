import 'package:filtered_list/dto/reaction.dart';

class User{
  final String name;
  final String bio;
  final Reaction reaction;

  User({required this.name, required this.bio, required this.reaction});
}