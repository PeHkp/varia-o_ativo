import 'package:dio/dio.dart';
import 'package:variacao_ativo/services/consult_value/consult_value_exception.dart';
import 'package:variacao_ativo/services/consult_value/consult_value_response.dart';

class ConsultValueRepository {
  final Dio dio;

  ConsultValueRepository({required this.dio});

  errorHandler(error) {
    throw ConsultValueException.fromMap(error);
  }

  Future<List<DaysProperty>> getDaysValue({
    required String action,
  }) async {
    try {
      Response<dynamic> response = await dio.get(
        '${dio.options.baseUrl}/$action?range=30d&interval=1d',
      );

      List<DaysProperty> listDays = response.data["results"][0]
              ["historicalDataPrice"]
          .map((day) => DaysProperty.fromResponse(data: day))
          .toList()
          .cast<DaysProperty>();

      return listDays;
    } on DioError catch (e) {
      return errorHandler(e);
    } catch (e) {
      return errorHandler(e.toString());
    }
  }
}
