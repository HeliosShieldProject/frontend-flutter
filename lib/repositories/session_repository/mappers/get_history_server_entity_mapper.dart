import 'package:Helios/common/constants/countries_constants.dart';
import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/interafces/country.dart';
import 'package:Helios/common/server/dto/dto.dart';
import 'package:Helios/repositories/session_repository/entities/get_history_server_entity.dart';

GetHistoryServerEntity getHistoryServerEntityMapper(
    {required BasicResponse response}) {
  return switch (response) {
    (Response _) => GetHistoryServerEntity(
        status: Auth.success,
        info: _historyInfoMapper(
          info: response.data as List<Map<String, dynamic>>,
        ),
      ),
    (ErrorResponse _) => GetHistoryServerEntity(
        status: Auth.values.firstWhere(
          (value) => value.name == response.error,
          orElse: () => Auth.failed,
        ),
      ),
    (_) => const GetHistoryServerEntity(status: Auth.failed),
  };
}

List<HistoryInfo> _historyInfoMapper(
    {required List<Map<String, dynamic>> info}) {
  final List<HistoryInfo> result = <HistoryInfo>[];

  final Map<String, Country> countryMap = <String, Country>{
    "UK": CountriesConstants.uk,
    "US": CountriesConstants.us,
    "Germany": CountriesConstants.de,
  };

  for (final history in info) {
    final Country country =
        countryMap[history["country"] as String] ?? CountriesConstants.unknown;
    result.add(
      HistoryInfo(
        country: country,
        dateTimeOpened: DateTime.parse(history["opened_at"] as String),
        dateTimeClosed: DateTime.parse(history["closed_at"] as String),
        duration: Duration(seconds: history["duration"] as int),
        device: history["device_id"] as String,
      ),
    );
  }

  return result;
}
