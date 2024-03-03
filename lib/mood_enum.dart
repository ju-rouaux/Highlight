enum Mood {
  happy,
  neutral,
  sad,
  bored,
  angry,
  anxious,
  thrilled,
  inLove,
  bitter,
}

extension MoodExtension on Mood {
  String get emoji {
    switch (this) {
      case Mood.happy:
        return '😄';
      case Mood.neutral:
        return '😐';
      case Mood.sad:
        return '😢';
      case Mood.bored:
        return '🥱';
      case Mood.angry:
        return '😠';
      case Mood.anxious:
        return '😰';
      case Mood.thrilled:
        return '🤩';
      case Mood.inLove:
        return '😍';
      case Mood.bitter:
        return '😒';
      default:
        return '';
    }
  }
}