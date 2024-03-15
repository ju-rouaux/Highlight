import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  none,
}

extension MoodExtension on Mood {
  String get toEmoji {
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
      case Mood.none:
        return '';
    }
  }

  String toLocalizedString(BuildContext context) {
    switch (this) {
      case Mood.happy:
        return AppLocalizations.of(context)!.happy;
      case Mood.neutral:
        return AppLocalizations.of(context)!.neutral;
      case Mood.sad:
        return AppLocalizations.of(context)!.sad;
      case Mood.bored:
        return AppLocalizations.of(context)!.bored;
      case Mood.angry:
        return AppLocalizations.of(context)!.angry;
      case Mood.anxious:
        return AppLocalizations.of(context)!.anxious;
      case Mood.thrilled:
        return AppLocalizations.of(context)!.thrilled;
      case Mood.inLove:
        return AppLocalizations.of(context)!.inLove;
      case Mood.bitter:
        return AppLocalizations.of(context)!.bitter;
      case Mood.none:
        return AppLocalizations.of(context)!.notSpecified;
    }
  }
}
