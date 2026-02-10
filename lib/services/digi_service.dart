import 'package:dio/dio.dart';
import 'package:opticcom/utils/dio_client.dart';
import 'package:opticcom/models/digi_model.dart';

class DigiService {
  final _dio = DioClient.dio;

  Future<List<DigiModel>> getDigimons() async {
    try {
      final response = await _dio.get('/digimon');
      final List listado = response.data['content'];
      return listado.map((e) => DigiModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error cargando la data: $e');
    }
  }
}