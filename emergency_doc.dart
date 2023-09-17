import 'package:flutter/material.dart';

void main() {
  runApp(EmergencyInterface());
}

class EmergencyInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Emergency Interface'),
          backgroundColor: Colors.red,
        ),
        body: EmergencyScreen(),
      ),
    );
  }
}

class EmergencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Estimated Wait Time
          Text(
            'Estimated Incoming Time: 15 mins', // Add your estimated time here
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),

          // Emergency Alert Button
          ElevatedButton(
            onPressed: () {
              // Trigger emergency action
              // Add functionality here
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: EdgeInsets.all(20.0),
            ),
            child: Text(
              'EMERGENCY ALERT!',
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          ),

          // Patient Information
          Card(
            elevation: 5.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/patient_photo.jpg'),
                radius: 30.0,
              ),
              title: Text(
                'Patient Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Age: 35'),
                  Text('Gender: Male'),
                  Text('Room: 305'),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),

          // Critical Actions
          ElevatedButton(
            onPressed: () {
              // Perform critical action
              // Add functionality here
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: EdgeInsets.all(20.0),
            ),
            child: Text(
              'ORDER TESTS',
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Perform critical action
              // Add functionality here
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              padding: EdgeInsets.all(20.0),
            ),
            child: Text(
              'ADMINISTER MEDICATION',
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          ),
          SizedBox(height: 20.0),

          // Communication
          Card(
            elevation: 5.0,
            child: ListTile(
              leading: Icon(Icons.message),
              title: Text('Chat with Nurse'),
              subtitle: Text('Request immediate assistance'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Open chat with nurse
                // Add functionality here
              },
            ),
          ),
          SizedBox(height: 20.0),

          // Location Information
          Card(
            elevation: 5.0,
            child: ListTile(
              leading: Icon(Icons.room),
              title: Text('Patient Location'),
              subtitle: Text('Room 305'),
            ),
          ),
          SizedBox(height: 20.0),

          // Emergency Contact
          Card(
            elevation: 5.0,
            child: ListTile(
              leading: Icon(Icons.phone),
              title: Text('Emergency Contact'),
              subtitle: Text('Call 102'),
              onTap: () {
                // Call emergency services
                // Add functionality here
              },
            ),
          ),
        ],
      ),
    );
  }
}
