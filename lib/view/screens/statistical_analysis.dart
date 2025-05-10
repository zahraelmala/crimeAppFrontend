import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticalAnalysisScreen extends StatelessWidget {
  // Sample data
  final Map<String, int> postsPerDay = {
    '2025-04-26': 2,
    '2025-04-27': 3,
    '2025-04-28': 1,
    '2025-04-29': 4,
    '2025-04-30': 2,
  };

  final Map<String, int> commentsPerDay = {
    '2025-04-26': 5,
    '2025-04-27': 8,
    '2025-04-28': 2,
    '2025-04-29': 7,
    '2025-04-30': 3,
  };

  List<FlSpot> _mapToSpots(Map<String, int> data) {
    final dates = data.keys.toList();
    return List.generate(dates.length, (index) {
      return FlSpot(index.toDouble(), data[dates[index]]!.toDouble());
    });
  }

  List<BarChartGroupData> _buildBarGroups(Map<String, int> data) {
    final dates = data.keys.toList();
    return List.generate(dates.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[dates[index]]!.toDouble(),
            color: Colors.red,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  List<PieChartSectionData> _buildPieSections() {
    final int totalPosts = postsPerDay.values.reduce((a, b) => a + b);
    final int totalComments = commentsPerDay.values.reduce((a, b) => a + b);
    final double total = (totalPosts + totalComments).toDouble();

    return [
      PieChartSectionData(
        value: totalPosts.toDouble(),
        title: 'Posts',
        color: Colors.red,
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: totalComments.toDouble(),
        title: 'Comments',
        color: Colors.blueGrey,
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final postSpots = _mapToSpots(postsPerDay);
    final commentSpots = _mapToSpots(commentsPerDay);
    final barGroups = _buildBarGroups(commentsPerDay);
    final pieSections = _buildPieSections();
    final dates = postsPerDay.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Statistical Analysis"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Text("📈 Line Chart: Posts & Comments Over Time", style: TextStyle(fontSize: 16)),
            AspectRatio(
              aspectRatio: 1.7,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          getTitlesWidget: (value, meta) {
                            int index = value.toInt();
                            if (index >= 0 && index < dates.length) {
                              return Text(dates[index].substring(5));
                            }
                            return Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(show: true),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: postSpots,
                        isCurved: true,
                        color: Colors.red,
                        dotData: FlDotData(show: true),
                        barWidth: 3,
                      ),
                      LineChartBarData(
                        spots: commentSpots,
                        isCurved: true,
                        color: Colors.blueGrey,
                        dotData: FlDotData(show: true),
                        barWidth: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Text("📊 Bar Chart: Comments Per Day", style: TextStyle(fontSize: 16)),
            AspectRatio(
              aspectRatio: 1.3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BarChart(
                  BarChartData(
                    barGroups: barGroups,
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            int index = value.toInt();
                            if (index >= 0 && index < dates.length) {
                              return Text(dates[index].substring(5));
                            }
                            return Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(show: true),
                    borderData: FlBorderData(show: true),
                  ),
                ),
              ),
            ),
            Divider(),
            Text("🥧 Pie Chart: Posts vs Comments", style: TextStyle(fontSize: 16)),
            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  sections: pieSections,
                  centerSpaceRadius: 40,
                  sectionsSpace: 4,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


