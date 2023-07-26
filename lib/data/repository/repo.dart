import 'package:planeta_uz/data/api/api.dart';
import 'package:planeta_uz/data/model/universal.dart';

class WtfRepository {
  WtfRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<UniversalData> getWtf() => apiProvider.fetchWtf();
}
