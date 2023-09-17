import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'emergency_doc.dart';

class DoctorHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Doctor'),
      ),
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/background_image.jpg', // Replace with your background image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Featured',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return FeaturedItemCard(index: index);
                    },
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Quick Access',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the respective page based on the index
                          _navigateToPage(context, index);
                        },
                        child: CategoryItemCard(
                          imagePath: getCategoryImagePath(index),
                          categoryName: getCategoryName(index),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.lightBlue.withOpacity(0.7),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home Page',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'ToDo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to get category image path
  String getCategoryImagePath(int index) {
    switch (index) {
      case 0:
        return 'assets/track.png';
      case 1:
        return 'assets/emergency.png';
      case 2:
        return 'assets/appointment.png';
      case 3:
        return 'assets/portfolio.png';
      case 4:
        return 'assets/attendance.png';
      case 5:
        return 'assets/progress.png';
      default:
        return 'assets/default.jpg'; // Default image path
    }
  }

  // Helper function to get category name
  String getCategoryName(int index) {
    switch (index) {
      case 0:
        return 'Track: RFID';
      case 1:
        return 'Emergency';
      case 2:
        return 'Appointment';
      case 3:
        return 'Portfolio';
      case 4:
        return 'Attendance';
      case 5:
        return 'Patient Progress';
      default:
        return 'Unknown Category'; // Default category name
    }
  }

  // Helper function to navigate to respective pages
  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TrackPage(),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EmergencyInterface(),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AppointmentPage(),
          ),
        );
        break;
      // Add cases for other categories as needed
    }
  }
}

class TrackPage extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/labelled_hospital_map.png',
    // Add more image paths if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Page'),
      ),
      body: PhotoViewGallery.builder(
        itemCount: imagePaths.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: AssetImage(imagePaths[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Colors.black,
        ),
        pageController: PageController(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DoctorHomePage(),
  ));
}

class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Page'),
      ),
      body: Center(
        child: Text('This is the Appointment Page'),
      ),
    );
  }
}

class FeaturedItemCard extends StatelessWidget {
  final int index;

  FeaturedItemCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.blue.withOpacity(0.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              'assets/news${index + 1}.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItemCard extends StatelessWidget {
  final String imagePath;
  final String categoryName;

  CategoryItemCard({required this.imagePath, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.lightBlue.withOpacity(0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imagePath,
            height: 100,
          ),
          SizedBox(height: 8),
          Text(
            categoryName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
