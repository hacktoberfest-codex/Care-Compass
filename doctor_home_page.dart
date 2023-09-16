import 'package:flutter/material.dart';

class DoctorHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Doctor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Featured section
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Featured',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Horizontal scroll view for featured items
            Container(
              height: 200, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Replace with the number of featured items
                itemBuilder: (context, index) {
                  // Create your featured item widgets here
                  return FeaturedItemCard();
                },
              ),
            ),
            // Top Categories section
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Top Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Grid view for top categories
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 1.0, // Adjust as needed
              ),
              itemCount: 6, // Replace with the number of categories
              itemBuilder: (context, index) {
                // Create your category item widgets here
                return CategoryItemCard();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturedItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your featured item card widget
    return Card(
      elevation: 3,
      child: Container(
        width: 150, // Adjust the width as needed
        child: Column(
          children: <Widget>[
            // Featured item image
            Image.asset(
              'assets/featured_item.png', // Replace with your image path
              height: 100, // Adjust the height as needed
            ),
            // Featured item title
            Text(
              'Featured Item',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your category item card widget
    return Card(
      elevation: 3,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Category item icon (e.g., medical symbol)
            Icon(
              Icons.medical_services,
              size: 50,
            ),
            SizedBox(height: 8),
            // Category item title (e.g., "Medical Services")
            Text(
              'Medical Services',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
