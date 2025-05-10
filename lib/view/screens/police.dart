import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PoliceStationLocationScreen extends StatefulWidget {
  @override
  _PoliceStationLocationScreenState createState() =>
      _PoliceStationLocationScreenState();
}

class _PoliceStationLocationScreenState
    extends State<PoliceStationLocationScreen> {
  String? selectedCity;
  bool isExpanded = false;

  Map<String, List<Map<String, dynamic>>> policeStations = {
    "Alexandria": [
      {
        "name": "Sidi Gaber Police Station",
        "location": "Near Sidi Gaber Train Station",
        "lat": 31.21497,
        "long": 29.93739
      },
      {
        "name": "Bab Sharq Police Station",
        "location": "Bab Sharq District, close to El-Horreya Road",
        "lat": 31.1981,
        "long": 29.9192
      },
      {
        "name": "Al-Montaza Police Station",
        "location": "Montaza District, close to Montaza Palace",
        "lat": 31.28502,
        "long": 30.01873
      },
      {
        "name": "Raml Police Station",
        "location": "Raml District, near Raml Station",
        "lat": 31.2482223,
        "long": 29.9748003
      },
      {
        "name": "Dekheila Police Station",
        "location": "Dekheila District, near the port area",
        "lat": 31.1936,
        "long": 29.8763
      },
      {
        "name": "Al-Laban Police Station",
        "location": "Al-Laban District, close to Al-Amriya area",
        "lat": 31.1906937,
        "long": 29.8959409
      },
      {
        "name": "Amriya Police Station",
        "location": "Amriya District, serves areas west of Alexandria.",
        "lat": 31.0100191,
        "long": 29.8060025
      },
      {
        "name": "Moharam Bek Police Station",
        "location": "Moharam Bek District, near downtown Alexandria.",
        "lat": 31.21288,
        "long": 29.92810
      },
    ]
  };

  void _openInGoogleMaps(double lat, double long) async {
    final url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$long");

    try {
      bool launched = await launchUrl(url, mode: LaunchMode.externalApplication);
      if (!launched) {
        print('Could not launch the URL');
      }
    } catch (e) {
      print('Could not launch URL: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Police Station", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCity ?? "Select City",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isExpanded)
            Expanded(
              child: ListView(
                children: policeStations.keys.map((city) {
                  return ListTile(
                    title: Center(
                      child: Text(city,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      setState(() {
                        selectedCity = city;
                        isExpanded = false;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          if (!isExpanded && selectedCity != null)
            Expanded(
              child: ListView.separated(
                itemCount: policeStations[selectedCity]!.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  var station = policeStations[selectedCity]![index];
                  return ListTile(
                    title: Center(
                      child: Text(
                        station["name"]!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Center(
                      child: Text(
                        station["location"]!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      _openInGoogleMaps(station["lat"], station["long"]);
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
