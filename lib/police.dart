import 'package:flutter/material.dart';



class PoliceStationLocationScreen extends StatefulWidget {
  @override
  _PoliceStationLocationScreenState createState() => _PoliceStationLocationScreenState();
}

class _PoliceStationLocationScreenState extends State<PoliceStationLocationScreen> {
  String? selectedCity;
  bool isExpanded = false;

  Map<String, List<Map<String, String>>> policeStations = {
    "Alexandria": [
      {"name": "Sidi Gaber Police Station", "location": "Near Sidi Gaber Train Station"},
      {"name": "Bab Sharq Police Station", "location": "Bab Sharq District, close to El-Horreya Road"},
      {"name": "Al-Montaza Police Station", "location": "Montaza District, close to Montaza Palace"},
      {"name": "Raml Police Station", "location": "Raml District, near Raml Station"},
      {"name": "Dekheila Police Station", "location": "Dekheila District, near the port area"},
      {"name": "Al-Laban Police Station", "location": "Al-Laban District, close to Al-Amriya area"},
      {"name": "Amriya Police Station", "location": "Amriya District, serves areas west of Alexandria."},
      {"name": "Moharam Bek Police Station", "location": "Moharam Bek District, near downtown Alexandria."},
    ],
    "Cairo": [
      {"name": "Nasr City Police Station", "location": "Nasr City, near City Stars Mall"},
      {"name": "Heliopolis Police Station", "location": "Heliopolis District, close to El Korba"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {},
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
                      isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
                      child: Text(city, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                      child: Text(station["name"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    subtitle: Center(
                      child: Text(station["location"]!, textAlign: TextAlign.center),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}