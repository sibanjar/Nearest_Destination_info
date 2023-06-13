import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';


class FilteredLocation {
  final double latitude;
  final double longitude;
  final double distance;
  final String name;
  final String imgurl;
  FilteredLocation({required this.distance, required this.latitude, required this.longitude, required this.name, required this.imgurl});
}



class LocationScreen {
  final double searchRadius = 600.0;
   static List<FilteredLocation> locations = [];

   void setlist(List<FilteredLocation> location1){
    locations =location1;
   }

  Future<void> fetchLocationsFromAPI() async {
    final response = await http.get(Uri.parse('your api url'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

        List<FilteredLocation> fetchedLocations = data.map((item) {
        return FilteredLocation(
          latitude: double.parse(item['Latitude']),
          longitude: double.parse(item['Longitude']),
          distance: calculateDistance(double.parse(item['Latitude']), double.parse(item['Longitude'])),
          name:item['Name'],
          imgurl:item['ImageURL'],
        );
      }).toList();
      List<FilteredLocation> filteredLocations = filterLocationsByRadius(fetchedLocations);

      setlist(filteredLocations);
     
    } else {
      throw Exception('Failed to fetch locations from API');
    }
  }
  

  double calculateDistance(double latitude, double longitude) {
    double distance = Geolocator.distanceBetween(
      27.67183690973489,
      85.42903234436557,
      latitude,
      longitude,
    );
    return distance;
  }


  List<FilteredLocation> filterLocationsByRadius(List<FilteredLocation> allLocations) {
    List<FilteredLocation> filteredLocations = [];

    for (var location in allLocations) {
      if (location.distance <= searchRadius) {
        filteredLocations.add(location);
      }
    }

    return filteredLocations;
  }
  
   List<FilteredLocation> returnfilteredLocations() {
    //fetchLocationsFromAPI();
    return locations ;
  }

}
