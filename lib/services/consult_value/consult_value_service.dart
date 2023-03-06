import 'package:variacao_ativo/services/consult_value/consult_value_repository.dart';
import 'package:variacao_ativo/services/consult_value/consult_value_response.dart';

class ConsultValueService {
  static ConsultValueService? _singleton;
  static get instance => _singleton;

  final ConsultValueRepository repository;

  ConsultValueService({required this.repository}) {
    if (_singleton == null) {
      _singleton = this;
    } else {
      throw Exception(
          "ConsultValueService already created. Use ConsultValueService.instance instead.");
    }
  }

  Future<List<DaysProperty>> getDaysValue({
    required action,
  }) async {
    List<DaysProperty> response = await repository.getDaysValue(
      action: action,
    );

    return response;
  }
}
