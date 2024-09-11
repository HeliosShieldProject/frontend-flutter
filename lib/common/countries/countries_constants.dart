import 'package:Helios/common/interafces/country.dart';
import 'country_impl.dart';

class CountriesConstants {
  static const Country uk =
      CountryImpl(countryCode: 'GB', countryName: "Великобритания");
  static const Country ru =
      CountryImpl(countryCode: "RU", countryName: "Россия");
  static const Country es =
      CountryImpl(countryCode: "ES", countryName: "Испания");
  static const Country de =
      CountryImpl(countryCode: "DE", countryName: "Германия");
  static const Country us = CountryImpl(countryCode: "US", countryName: "США");
}
