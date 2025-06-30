import 'package:flutter/material.dart';
import 'transfer_page.dart';

void main() {
  runApp(DailyPayStyleApp());
}

class DailyPayStyleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DailyCheck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Helvetica', primarySwatch: Colors.indigo),
      home: EarningsPage(),
    );
  }
}

class EarningsPage extends StatelessWidget {
  final double available = 489.53;
  final double transferred = 100.00;
  final double fees = 10.47;
  final double saved = 80.00;

  @override
  Widget build(BuildContext context) {
    double total = available + transferred + fees + saved;
    double barAvailable = available / total;
    double barTransferred = transferred / total;
    double barFees = fees / total;
    double barSaved = saved / total;

    return Scaffold(
      backgroundColor: Color(0xFFF6F8FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text("Good morning, John.", style: TextStyle(fontSize: 20)),
              SizedBox(height: 4),
              Text(
                "Your earnings just went up!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(height: 30),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "\$$available",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TransferPage(
                                availableAmount: available,
                                username: "John", // 后期可换成登录用户
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.indigo,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Start transfer",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Earnings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                "Last reported Apr 22, 6:01pm",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Flexible(
                    flex: (barTransferred * 1000).toInt(),
                    child: Container(height: 10, color: Colors.yellow[800]),
                  ),
                  Flexible(
                    flex: (barFees * 1000).toInt(),
                    child: Container(height: 10, color: Colors.red[400]),
                  ),
                  Flexible(
                    flex: (barSaved * 1000).toInt(),
                    child: Container(height: 10, color: Colors.blue[300]),
                  ),
                  Flexible(
                    flex: (barAvailable * 1000).toInt(),
                    child: Container(height: 10, color: Colors.green[400]),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  _buildEarningRow("Transferred", transferred),
                  _buildEarningRow("Fees", fees),
                  _buildEarningRow("Saved until payday", saved),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarningRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(
            "\$$amount",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
