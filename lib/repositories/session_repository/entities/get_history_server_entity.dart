import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/interafces/country.dart';
import 'package:equatable/equatable.dart';

class GetHistoryServerEntity implements BasicServerEntity {
  const GetHistoryServerEntity({
    required this.status,
    this.info,
  });

  final List<HistoryInfo>? info;

  @override
  final Auth status;
}

class HistoryInfo extends Equatable {
  const HistoryInfo({
    required this.dateTimeOpened,
    required this.dateTimeClosed,
    required this.country,
    required this.duration,
    required this.device,
  });

  final DateTime dateTimeOpened;
  final DateTime dateTimeClosed;
  final Country country;
  final Duration duration;
  final String device;

  @override
  List<Object?> get props => [
        dateTimeOpened,
        dateTimeClosed,
        country,
        duration,
        device,
      ];
}
