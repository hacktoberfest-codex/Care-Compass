import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'appointment_page.dart';

void main() {
  runApp(PatientApp());
}

class PatientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PatientHomePage(),
    );
  }
}

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/background_image.jpg', // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Existing content
          SingleChildScrollView(
            child: Column(
              children: [
                _buildNewsCarousel(),
                SizedBox(height: 16), // Add spacing from the top
                _buildQuickAccessMenu(),
                SizedBox(
                    height: 16), // Add spacing between Quick Access and Body
                _buildBody(_selectedIndex),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Navigate to the home screen
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ListTile(
              title: Text('List'),
              onTap: () {
                // Navigate to the List screen
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                // Navigate to the Profile screen
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCarousel() {
    return CarouselSlider(
      items: [
        // Carousel items with images and news details
        Card(
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/news11.jpg', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text('A special visit',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('PM modi take tour of hospital'),
              ),
            ],
          ),
        ),
        Card(
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/news22.jpg', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text('COVID-19 updates',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('A new variant found'),
              ),
            ],
          ),
        ),
        Card(
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/news3.jpg', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text('Do' 's and Dont' 's',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle:
                    Text('Take a tour of what to do in case of emergency'),
              ),
            ],
          ),
        ),
        // Add more carousel items with images and news details as needed
      ],
      options: CarouselOptions(
        height: 200.0, // Adjust the carousel height as needed
        autoPlay: true,
        enlargeCenterPage: true,
      ),
    );
  }

  Widget _buildQuickAccessMenu() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildQuickAccessItem('Appointment', Icons.event, () {
          // Navigate to the Appointment page
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AppointmentPage()));
        }),
        _buildQuickAccessItem('Emergency', Icons.local_hospital, () {
          // Navigate to the Emergency page
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => EmergencyPage()));
        }),
        _buildQuickAccessItem('Health History', Icons.history, () {
          // Navigate to the Health History page
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HealthHistoryPage()));
        }),
        _buildQuickAccessItem('Review', Icons.star, () {
          // Navigate to the Review page
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ReviewPage()));
        }),
        // Add more Quick Access items as needed
      ],
    );
  }

  Widget _buildQuickAccessItem(
      String title, IconData icon, void Function()? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2), // Adjust the opacity as needed
          borderRadius: BorderRadius.circular(10.0), // Add rounded corners
          border: Border.all(
            color: Colors.blue, // Border color
            width: 1.0, // Border width
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 100, // Adjust the icon size as needed
              color: Colors.blue,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return _buildHomePageContent();
      case 1:
        return Container(); // You can return an empty container for "List" for now
      case 2:
        return Container(); // You can return an empty container for "Profile" for now
      default:
        return Container();
    }
  }

  Widget _buildHomePageContent() {
    return Center(
      child: Text('Home Page Content'),
    );
  }

  void _navigateToListPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ListPage(),
      ),
    );
  }

  void _navigateToProfilePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProfilePage(),
      ),
    );
  }
}

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency'),
      ),
      body: Center(
        child: Text('Emergency Page Content'),
      ),
    );
  }
}

class HealthHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health History'),
      ),
      body: Center(
        child: Text('Health History Page Content'),
      ),
    );
  }
}

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review'),
      ),
      body: Center(
        child: Text('Review Page Content'),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
      ),
      body: Center(
        child: Text('List Page Content'),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Text('Profile Page Content'),
      ),
    );
  }
}
