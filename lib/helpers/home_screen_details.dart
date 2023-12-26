import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_siddur/helpers/home_screen_details_repository.dart';

final providerServiceProvider =
    ChangeNotifierProvider<ProviderService>((ref) {
  return ProviderService();
});