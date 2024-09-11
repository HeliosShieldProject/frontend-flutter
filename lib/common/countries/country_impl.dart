import 'package:Helios/common/interafces/country.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class CountryImpl implements Country {
  const CountryImpl({
    required this.countryCode,
    required this.countryName,
  });

  @override
  final String countryCode;

  @override
  final String countryName;

  @override
  Widget get flag => CountryFlag.fromCountryCode(countryCode);
}
