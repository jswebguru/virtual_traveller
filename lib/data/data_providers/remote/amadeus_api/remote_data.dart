import 'package:meta/meta.dart';
import 'package:virtual_traveller_flutter/data/data_providers/remote/amadeus_api/api_service.dart';
import 'package:virtual_traveller_flutter/data/models/location.dart';
import 'package:virtual_traveller_flutter/data/models/poi.dart';

import 'base_data.dart';

/// This does the network calls.
///
/// **Quick links**
///
/// *Flights related*:
/// - [getRawNearestAirport]
/// - [getRawFlightOffersSearch]
/// - [getRawFlightCheapestDateSearch]
/// - [getRawAirportCitySearch]
/// - [getRawAirlineCodeLookup]
///
/// *Home Page & Destinations related*:
/// - [getRawFlightMostBooked]
/// - [getRawFlightMostTravelled]
/// - [getRawTravelRecommendation]
/// - [getRawHotelSearch]
/// - [getRawPointsOfInterest]
/// - [getRawSafePlace]
class AmadeusRemoteDataProvider implements AmadeusBaseDataProvider {
  AmadeusRemoteDataProvider(this._apiService);

  final ApiService _apiService;

  // https://developers.amadeus.com/self-service/category/air/api-doc/airport-nearest-relevant/api-reference
  @override
  Future<String> getRawNearestAirport(
    Location location,
  ) async {
    final endpointPath = 'v1/reference-data/locations/airports';
    final queryParams = {
      'latitude': location.lat, // ---REQUIRED---
      'longitude': location.long, // ---REQUIRED---
      'page[limit]': 10 // maximum items in one page
    };

    return await _apiService.getRawDataFromEndpoint(endpointPath, queryParams);
  }

  // https://developers.amadeus.com/self-service/category/air/api-doc/flight-offers-search/api-reference
  @override
  Future<String> getRawFlightOffersSearch({
    @required String originCity,
    @required String destinationCity,
    @required String departureDate,
    String returnDate,
    @required int adults,
    int children,
    int infants,
    String travelClass,
    bool nonStop,
    String currencyCode,
    int maxPrice,
  }) async {
    final endpointPath = 'v2/shopping/flight-offers';
    final queryParams = {
      'originLocationCode': originCity, // ---REQUIRED---, (eg.: 'SYD') IATA code
      'destinationLocationCode': destinationCity, // ---REQUIRED---, (eg.: 'BKK') IATA code
      'departureDate': departureDate, // ---REQUIRED---, (eg.: 2017-12-25) ISO 8601 YYYY-MM-DD format
      'returnDate': returnDate, // (eg.: 2018-02-28) format same as departureDate, if null then it is one-way, otherwise round-trip
      'adults': adults, // ---REQUIRED---, (eg.: 1) the number of adult travelers (age 12 or older on date of departure)
      'children': children, // (eg.: 0) the number of child travelers (older than age 2 and younger than age 12 on date of departure)
      'infants': infants, // (eg.: 0) the number of infant travelers (whose age is less or equal to 2 on date of departure), infants travel on the lap of an adult traveler, and thus the number of infants must not exceed the number of adults
      'travelClass': travelClass, // (eg.: 'ECONOMY') ECONOMY, PREMIUM_ECONOMY, BUSINESS, FIRST; if no travel class is specified, the search considers any travel class
      'nonStop': nonStop, // if set to true, the search will find only flights going from the origin to the destination with no stop in between. Default value : false
      'currencyCode': currencyCode, // (eg.: 'USD') the preferred currency for the flight offers, currency is specified in the ISO 4217 format, e.g. EUR for Euro
      'maxPrice': maxPrice, // (eg.: 500) maximum price per traveler, by default, no limit is applied, if specified, the value should be a positive number with no decimals
      'max': 50, // maximum number of flight offers to return, if specified, the value should be greater than or equal to 1 (default 250)
    };

    return await _apiService.getRawDataFromEndpoint(endpointPath, queryParams);
  }

  // https://developers.amadeus.com/self-service/category/air/api-doc/flight-cheapest-date-search/api-reference
  @override
  Future<String> getRawFlightCheapestDateSearch({
    @required String originCity,
    @required String destinationCity,
  }) async {
    final currDate = DateTime.now();
    final currDateFormatted = '${currDate.year}-${currDate.month}-${currDate.day}';

    final endpointPath = 'v1/shopping/flight-dates';
    final queryParams = {
      'origin': originCity, // ---REQUIRED---, (eg.: 'SYD') IATA code of the city from which the flight will depart, e.g. MAD for Madrid http://www.iata.org/publications/Pages/code-search.aspx
      'destination': destinationCity, // ---REQUIRED---, (eg.: 'MUC') IATA code of the city to which the flight is going
      'departureDate': currDateFormatted, // the date, or range of dates, on which the flight will depart from the origin. Dates are specified in the ISO 8601 YYYY-MM-DD format, e.g. 2017-12-25. Ranges are specified with a comma and are inclusive
      'oneWay': true, // if this parameter is set to true, only one-way flights are considered. If this parameter is not set or set to false, only round-trip flights are considered. Default: false
    };

    return await _apiService.getRawDataFromEndpoint(endpointPath, queryParams);
  }

  // https://developers.amadeus.com/self-service/category/air/api-doc/airport-and-city-search/api-reference
  @override
  Future<String> getRawAirportCitySearch(
    String textSearchKeyword,
  ) async {
    final endpointPath = 'v1/reference-data/locations';
    final queryParams = {
      'keyword': textSearchKeyword, // --REQUIRED--, (eg.: 'MUC') keyword that should represent the start of a word in a city or airport name or code
      'subType': 'CITY', // --REQUIRED--, array[string], sub type of the location (AIRPORT and/or CITY). Available values : AIRPORT, CITY
      'page[limit]': 10, // maximum items in one page, default value: 10
    };

    return await _apiService.getRawDataFromEndpoint(endpointPath, queryParams);
  }

  // https://developers.amadeus.com/self-service/category/air/api-doc/airline-code-lookup/api-reference
  @override
  Future<String> getRawAirlineCodeLookup(
    String airlineCode,
  ) async {
    final endpointPath = 'v1/reference-data/airlines';
    final queryParams = {
      // Code of the airline following IATA standard (IATA table codes: http://www.iata.org/publications/Pages/code-search.aspx)
      // or ICAO standard (ICAO airlines table codes: https://en.wikipedia.org/wiki/List_of_airline_codes).

      // Several airlines can be selected at once by sending a list separated by a coma (i.e. AF, SWA).
      // (eg.: 'BA')
      'airlineCodes': airlineCode,
    };

    return await _apiService.getRawDataFromEndpoint(endpointPath, queryParams);
  }

  // https://developers.amadeus.com/self-service/category/air/api-doc/flight-most-booked-destinations/api-reference
  @override
  Future<String> getRawFlightMostBooked(
    String originCityCode,
  ) async {
    final currDate = DateTime.now();
    final currDateFormatted = '${currDate.year}-${currDate.month}';

    final endpointPath = 'v1/travel/analytics/air-traffic/booked';
    final queryParams = {
      'originCityCode': originCityCode, // ---REQUIRED--- (eg.: 'MAD') Code for the origin city following IATA standard (IATA table codes). - e.g. BOS for Boston. http://www.iata.org/publications/Pages/code-search.aspx
      'period': currDateFormatted, // (eg.: '2019-09') Period when consumers are traveling. It can be a month only. ISO format must be used - e.g. 2015-05. Period ranges are not supported. Only periods from 2011-01 up to previous month are valid. Future dates are not supported.
      'max': 15, // Maximum number of destinations in the response. Default value is 10 and maximum value is 50.
      'page[limit]': 15, // maximum items in one page, default value : 10
    };

    return await _apiService.getRawDataFromEndpoint(endpointPath, queryParams);
  }

  // https://developers.amadeus.com/self-service/category/air/api-doc/flight-most-traveled-destinations/api-reference
  @override
  Future<String> getRawFlightMostTravelled(
    String originCityCode,
  ) async {
    final currDate = DateTime.now();
    final currDateFormatted = '${currDate.year}-${currDate.month}';

    final endpointPath = 'v1/travel/analytics/air-traffic/traveled';
    final queryParams = {
      'originCityCode': originCityCode, // ---REQUIRED--- (eg.: 'MAD') Code for the origin city following IATA standard (IATA table codes). - e.g. BOS for Boston http://www.iata.org/publications/Pages/code-search.aspx
      'period': currDateFormatted, // ---REQUIRED--- (eg.: '2019-09') Period when consumers are traveling. It can be a month only. ISO 8601 format must be used - e.g. 2015-05. Period ranges are not supported. Only periods from 2011-01 up to previous month are valid. Future dates are not supported. https://en.wikipedia.org/wiki/ISO_8601
      'max': 15, // maximum number of destinations in the response. Default value is 10 and maximum value is 50.
      'page[limit]': 15, // maximum items in one page, default is 10
    };

    return await _apiService.getRawDataFromEndpoint(endpointPath, queryParams);
  }

  // https://developers.amadeus.com/self-service/category/trip/api-doc/travel-recommendations/api-reference
  @override
  Future<String> getRawTravelRecommendation(
    List<String> cityCodes,
  ) async {
    final endpointPath = 'v1/reference-data/recommended-locations';
    final queryParams = {
      'cityCodes': cityCodes, // ---REQUIRED--- (eg.: 'PAR') City used by the algorithm to recommend new destination. Several cities can be specified using comma. City codes follow IATA standard http://www.iata.org/publications/Pages/code-search.aspx
    };

    return await _apiService.getRawDataFromEndpoint(endpointPath, queryParams);
  }

  // https://developers.amadeus.com/self-service/category/hotel/api-doc/hotel-search/api-reference
  @override
  Future<String> getRawHotelSearch({
    @required cityCode,
    String language,
  }) async {
    final endpointPath = 'v2/shopping/hotel-offers';
    final queryParams = {
      'cityCode': cityCode, // ---REQUIRED--- (eg.: 'PAR') Destination City Code (or Airport Code). In case of city code, the search will be done around the city center. Available codes can be found in IATA table codes (3 chars IATA Code). http://www.iata.org/publications/Pages/code-search.aspx
      'radius': 5, // ---REQUIRED--- maximum distance (in radiusUnit) from Destination (city center or geocodes). Default value: 5
      'radiusUnit': 'KM', // ---REQUIRED--- distance unit (of the radius value). Available values : KM, MILE
      'ratings': [5, 4, 3], // array[integer], hotel stars, up to 4 values can be requested at the same time in a comma separated list

      // requested language of descriptive texts:
      // examples: FR , fr , fr-FR
      // if a language is not available the text will be returned in english
      // ISO language code (https://www.iso.org/iso-639-language-codes.html)
      'lang': language,

      // hotel descriptive content to include in the response:
      //  - NONE: geocoordinates, hotel distance
      //  - LIGHT: NONE view + city name, phone number, fax, address, postal code, country code, state code, ratings, 1 image
      //  - FULL: LIGHT view + hotel description, amenities and facilities
      'view': 'FULL',

      'page[limit]': 10,
    };

    return await _apiService.getRawDataFromEndpoint(endpointPath, queryParams);
  }

  // https://developers.amadeus.com/self-service/category/destination-content/api-doc/points-of-interest/api-reference
  @override
  Future<String> getRawPointsOfInterest({
    @required Location location,
    List<String> categories,
  }) async {
    final endpointPath = 'v1/reference-data/locations/pois';
    final queryParams = {
      'latitude': location.lat, // ---REQUIRED---
      'longitude': location.long, // ---REQUIRED---
      'categories': categories, // array[string], category of the location. Available values (multiple can be used): SIGHTS, NIGHTLIFE, RESTAURANT, SHOPPING
      'radius': 5, // radius of the search in kilometer, can be from 0 to 20, default value is 1 km
      'page[limit]': 30, // maximum items in one page, default value : 10
    };

    return await _apiService.getRawDataFromEndpoint(endpointPath, queryParams);
  }

  // https://developers.amadeus.com/self-service/category/destination-content/api-doc/safe-place-api/api-reference
  @override
  Future<String> getRawSafePlace(
    Location location,
  ) async {
    final endpointPath = 'v1/safety/safety-rated-locations';
    final queryParams = {
      'latitude': location.lat, // ---REQUIRED---
      'longitude': location.long, // ---REQUIRED---
      'page[limit]': 1, // maximum items in one page (enough is to see safety only of the city and not also of the each district)
    };

    return await _apiService.getRawDataFromEndpoint(endpointPath, queryParams);
  }
}
