import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_traveller_flutter/data/models/hotel.dart';
import 'package:virtual_traveller_flutter/utils/extensions.dart';

import 'local_widgets/image_sliver_app_bar.dart';

class HotelDetailsPage extends StatelessWidget {
  static Route route({
    @required Hotel hotel,
  }) {
    return MaterialPageRoute(
      builder: (_) {
        return HotelDetailsPage();
      },
      settings: RouteSettings(
        arguments: hotel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Hotel hotel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          buildSliverAppBar(
            context,
            hotelName: hotel.name,
            city: hotel.address?.cityName,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BUTTON TO SEARCH FLIGHTS (if from watchlist/home page)\n\nBasic info: City name, Country name, Country abbreviation',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ),
                                Text(
                                  '\nLocation\nlat: xyz longitude: xyz',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ),
                                Text(
                                  '\nAverage temperature last week: xyz',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1400),
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  ImageSliverAppBar buildSliverAppBar(
    BuildContext context, {
    @required String hotelName,
    String city = '',
  }) {
    return ImageSliverAppBar(
      // TODO: Add hotel picture
      assetName: 'most_popular_destination3.jpg',
      title: hotelName.toPascalCase(),
      twoLineTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.copy),
          tooltip: 'Copy name of the hotel',
          onPressed: () {
            final textData = '${hotelName.toPascalCase()} hotel ${city}';
            Clipboard.setData(
              ClipboardData(
                text: textData,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Hotel \'${hotelName.toPascalCase()}\' was copied to the clipboard.',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
