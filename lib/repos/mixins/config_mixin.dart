import 'package:get_it/get_it.dart';
import 'package:peak_progress/repos/flagsmith.dart';

mixin ConfigMixin {
  final _flagsmith = GetIt.instance<Flagsmith>();

  String get privacyLink => _flagsmith.config.privacyLink;

  String get termsLink => _flagsmith.config.termsLink;
}
