import 'package:flutter/material.dart';

enum Reaction {
  thumbsUp,
  thumbsDown,
}

extension ReactionExtension on Reaction {
  IconData get icon {
    switch (this) {
      case Reaction.thumbsUp:
        return Icons.thumb_up;
      case Reaction.thumbsDown:
        return Icons.thumb_down;
    }
  }
}
