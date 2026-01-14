import 'package:flutter/material.dart';
import "package:navicare/l10n/app_localization.dart";

String getTimeBasedGreeting(BuildContext context) {
  final hour = DateTime.now().hour;
  final l10n = AppLocalizations.of(context)!;

  if (hour >= 5 && hour < 12) {
    //return l10n.goodMorning;
    return "Good Morning";
  } else if (hour >= 12 && hour < 17) {
    //return l10n.goodAfternoon;
    return "Good Afternoon";
  } else if (hour >= 17 && hour < 21) {
    //return l10n.goodEvening;
    return "Good Evening";
  } else {
    //return l10n.goodNight;
    return "Good Night";
  }
}
