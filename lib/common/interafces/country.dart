import 'package:flutter/material.dart';

abstract interface class Country {
  const Country({
    required this.countryCode,
    required this.countryName,
  });

  final String countryCode;
  final String countryName;

  Widget get flag;
}
