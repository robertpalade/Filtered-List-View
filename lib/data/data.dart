import '../dto/user.dart';
import '../dto/reaction.dart';

List<User> users = <User>[
  User(name: "Ema Watson", bio: "", reaction: Reaction.thumbsUp),
  User(name: "Bill Jobs", bio: "Check me on twitter @bill", reaction: Reaction.thumbsDown),
  User(
      name: "Piper E.",
      bio:
          "Total food specialist. Friendly webaholic. Coffee fan. Proud analyst. "
          "TV Expert. Explorer. Travel Nerd. Incurable beer advocate.", reaction: Reaction.thumbsUp),
  User(name: "Liam Nelson", bio: "Shiba to the moon!", reaction: Reaction.thumbsDown),
  User(name: "Max Verstappen", bio: "Catch me if you can", reaction: Reaction.thumbsUp),
  User(name: "Lewis Hamilton", bio: "", reaction: Reaction.thumbsDown),
  User(name: "Ana Camille", bio: "", reaction: Reaction.thumbsUp),
];
