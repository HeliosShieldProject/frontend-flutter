import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/interafces/country.dart';
import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/repositories/session_repository/entities/get_history_server_entity.dart';
import 'package:Helios/repositories/session_repository/low_level/get_history.dart';

Future<List<HistoryInfo>> getHistory({
  required User user,
  int? limit,
  int? offset,
  List<Country>? countries,
  List<String>? devices,
}) async {
  late final BasicServerEntity result;

  final Map<String, String> countryMap = <String, String>{
    "GB": "UK",
    "US": "US",
    "DE": "Germany",
  };

  try {
    result = await serverGetHistory(
        accessToken: user.jwtToken!,
        limit: limit,
        offset: offset,
        countries: countries
            ?.map((value) => countryMap[value.countryCode] ?? "UK")
            .toList(),
        devices: devices);
  } catch (e) {
    throw Auth.failed;
  }

  if (result.status != Auth.success) {
    throw result.status;
  }

  result as GetHistoryServerEntity;
  return result.info!;
}
