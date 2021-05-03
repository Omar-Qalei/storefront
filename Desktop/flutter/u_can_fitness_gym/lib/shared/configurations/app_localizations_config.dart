import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocalizationsConfig {
  static AppLocalizations? appLocalizations;
  void init(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
  }
}
