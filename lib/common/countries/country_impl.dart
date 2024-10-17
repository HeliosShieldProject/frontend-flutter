import 'package:Helios/common/interafces/country.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'country_impl.g.dart';

@HiveType(typeId: 6)
class CountryImpl implements Country {
  const CountryImpl({
    required this.countryCode,
    required this.countryName,
  });

  @HiveField(0)
  @override
  final String countryCode;

  @HiveField(1)
  @override
  final String countryName;

  @override
  Widget get flag => CountryFlag.fromCountryCode(countryCode);
}
