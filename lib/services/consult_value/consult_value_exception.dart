import 'package:dio/dio.dart';

class ConsultValueException {
  final String errorDescription;
  final String errorCode;

  ConsultValueException(this.errorDescription, this.errorCode);

  ConsultValueException.fromMap(DioError map)
      : errorCode = map.response!.statusCode.toString(),
        errorDescription = map.response!.data["error"] ??
            "Erro inesperado aconteceu, tente mais tarde!";
}
