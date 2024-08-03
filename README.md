# Virtual Traveller
![Build](https://img.shields.io/badge/Framework-Flutter-blue.svg)&nbsp;&nbsp;&nbsp;&nbsp;![Build](https://github.com/jswebguru/virtual_traveller/workflows/build/badge.svg) [![codecov](https://codecov.io/gh/jswebguru/virtual_traveller/branch/master/graph/badge.svg)](https://codecov.io/gh/jswebguru/virtual_traveller)

Search for flights and deep dive into large offers of travelling destinations. Discover recommended and popular places. Hop on on the virtual mode to simulate travelling immediately to your desired destination and learn more about it, including interesting information and points of interests! 🚀

## Previews
<p align="left">
<img height="450" width="auto" src="github_images/app_preview_home1.png" />
<img height="450" width="auto" src="github_images/app_preview_home2.png" />
</p>
<p align="left">
<img height="450" width="auto" src="github_images/app_preview_flights1.jpg" />
</p>
<p align="left">
<img height="450" width="auto" src="github_images/app_preview_watchlist1.png" />
<img height="450" width="auto" src="github_images/app_preview_watchlist2.png" />
</p>
<p align="left">
<img height="450" width="auto" src="github_images/app_preview_destination_info1.png" />
<img height="450" width="auto" src="github_images/app_preview_pois1.png" />
<img height="450" width="auto" src="github_images/app_preview_hotels1.png" />
</p>
<p align="left">
<img height="450" width="auto" src="github_images/app_preview_settings1.png" />
</p>

## How to run
1. Clone this repository
2. Fetch packages:</br>
```flutter pub get```
3. 	- Run freezed and json_serializable code generators:</br>
```flutter pub run build_runner build --delete-conflicting-outputs```</br>
	- Automatically rebuild on changes with:</br>
```flutter pub run build_runner watch```
4. 	- Run on the device:</br>
```flutter run``` (run in Profile mode if you want to test the performance)</br>
	- Run on the web (make sure you are on the **beta** channel):</br>
```flutter run -d web```</br>
	- Run with flag on the web with better performance (experimental):</br>
```flutter run -d web --release --dart-define=FLUTTER_WEB_USE_SKIA=true```</br>
	- Run on the desktop (Windows) (make sure you are on the **dev** channel):</br>
```flutter run -d windows```</br></br>

**NOTE:** If you want to use remote APIs instead of local fake data, you need to obtain API key(s).
The web preview version uses fake data because it is built from the repository and API keys would get exposed.</br>
[Obtain the Amadeus Travel API key here](https://developers.amadeus.com/get-started/get-started-with-self-service-apis-335).

Then:
- place the key to this file: *lib/data/data_providers/remote/secrets.dart*
- set **quotaSaveMode** to ```false``` in *lib/utils/debug_options.dart*

## Idea
I wanted to make a flight searching app with interesting suggestions, fully from the scratch. However, due to the current situation with the pandemic, many countries are restricted for some citizens so travelling there isn't possible. This app has virtual travelling mode, which simulates the travelling here, displays interesting information about the desired location, including picture, points of interests and etc. There's a possibility to save the locations, so you can check them out later!

Powered by the [Amadeus for Developers API](https://developers.amadeus.com/), which fits best for this use and offers also free monthly quota for testing! Amadeus Travel APIs connect you to the richest information in the travel industry.

## Visualizing the flow of the app
![visualizing the flow of the app](https://github.com/jswebguru/virtual_traveller/blob/master/github_images/visualmap.png)

## App Architecture
Using the bloc library allows us to separate our application into three layers:

- Presentation
- Business Logic
- Data
  - Repository
  - Data Provider
  - Models

<p align="center">
<img height="170" width="auto" src="https://bloclibrary.dev/assets/bloc_architecture_full.png" />
</p>

<p align="center">
<img height="170" width="auto" src="https://bloclibrary.dev/assets/cubit_architecture_full.png" />
</p>

## State management 
There's no unique rule on what to choose because it always depends on many criteria. When it came to deciding on which state management approach to use in my case, I was deciding between Provider and bloc library. Bloc library is already dependant on Provider package so it is fairly similar in terms of a dependency injection (DI) (a single instance of a Cubit or Bloc can be provided to all of the widgets within a subtree). [Read more here about bloc library](https://bloclibrary.dev/#/) and [Provider](https://pub.dev/packages/provider).

The reasons why I decided to use the bloc library in my case were following:
- use of the reactive streams, which goes well together with BLoC pattern
- easy and reliable tests via bloc_test library, which is based on Mockito
- it isn't only a state management library, but it also helps implement the BLoC (Business Logic Component) design pattern

## Dependencies:
- #### Common packages:
    - [pedantic](https://pub.dev/packages/pedantic)
    - [equatable](https://pub.dev/packages/equatable)
    - [flutter_bloc](https://pub.dev/packages/flutter_bloc)
    - [bloc_test](https://pub.dev/packages/bloc_test)
    - [mockito](https://pub.dev/packages/mockito)
    - [http](https://pub.dev/packages/http)
    - [rx_dart](https://pub.dev/packages/rxdart)
    - [freezed](https://pub.dev/packages/freezed)
    - [build_runner](https://pub.dev/packages/build_runner)
    - [json_serializable](https://pub.dev/packages/json_serializable)
    - [shared_preferences](https://pub.dev/packages/shared_preferences)
    - [url_launcher](https://pub.dev/packages/url_launcher)
    - [geolocator](https://pub.dev/packages/geolocator)

- #### UI packages:
    - [clean_settings](https://pub.dev/packages/clean_settings)
    - [flutter_typeahead](https://pub.dev/packages/flutter_typeahead)
    - [shimmer](https://pub.dev/packages/shimmer)

## UI inspirations
- [Material Design - Crane Travel App](https://material.io/design/material-studies/crane.html)
- [Search Flights - Mobile Booking App UI Design by Nitish Khagwal](https://dribbble.com/shots/10749939-Search-Flights-Mobile-Booking-App-UI-Design)
- [Flight Tickets Deal Tracker App | Day 340/365 - Project365 by Kishore](https://dribbble.com/shots/5662956-Flight-Tickets-Deal-Tracker-App-Day-340-365-Project365)

## Related recommended resources
- [Amadeus Travel API](https://developers.amadeus.com/self-service)
- [flutter_bloc package docs](https://bloclibrary.dev/#/)
- [Flutterly YouTube Channel - about BLoC](https://www.youtube.com/channel/UC5PYcSe3to4mtm3SPCUmjvw)
- [Freezed ❄ – Data Class & Union in One Dart Package - by Reso Coder](https://resocoder.com/2020/02/11/freezed-data-class-union-in-one-dart-package/#t-1600693077177)
- [Flutter Internationalization User Guide](http://flutter.dev/go/i18n-user-guide)

## Credits
- [Unsplash](https://unsplash.com/) (Asset Images)
