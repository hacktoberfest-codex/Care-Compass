import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'doctor_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital Appointment System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DoctorLoginPage(),
    );
  }
}

class DoctorLoginPage extends StatefulWidget {
  @override
  _DoctorLoginPageState createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  bool _isLogin = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _responseCode = ''; // Variable to store the response code

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  Future<void> _verifyLogin(String username, String password) async {
    final url = Uri.parse('http://192.168.1.3:12345');
    final response = await http.post(
      url,
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}'); // Print the response body

    if (response.statusCode == 200) {
      // Successful login
      print('Login successful');
      final responseBody = jsonDecode(response.body);
      print('Response body: $responseBody'); // Debug print the response body

      // Navigate to the DoctorHomePage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => DoctorHomePage(),
        ),
      );
    } else if (response.statusCode == 401) {
      // Proceed to login even if it's 401
      print('Proceeding to login');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => DoctorHomePage(), // Replace with your login page
        ),
      );
    } else {
      // Handle other error cases
      print('Login failed');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Login failed. Please check your credentials. Response Code: ${response.statusCode}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLogin ? 'Doctor Login' : 'Doctor Sign Up',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_isLogin) _buildInputField('Name', Icons.person),
                if (!_isLogin) SizedBox(height: 20),
                if (!_isLogin) _buildInputField('Specialization', Icons.work),
                if (!_isLogin) SizedBox(height: 20),
                if (!_isLogin)
                  _buildUploadButton('Upload Certificate', Icons.file_upload),
                _buildInputField('Doctor Username', Icons.person_outline),
                SizedBox(height: 20),
                _buildInputField('Password', Icons.lock_outline,
                    isPassword: true),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _verifyLogin(
                      usernameController.text,
                      passwordController.text,
                    );
                  },
                  child: Text(
                    _isLogin ? 'Login' : 'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: _toggleForm,
                  child: Text(
                    _isLogin
                        ? "Don't have an account? Sign Up"
                        : 'Already have an account? Login',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (!_isLogin) SizedBox(height: 20),
                if (!_isLogin)
                  _buildUploadButton('Upload Photo', Icons.camera_alt),
                // Display the response code on the screen
                Text(
                  'Response Code: $_responseCode',
                  style: TextStyle(
                    color: Colors.red, // You can customize the color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, IconData icon,
      {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          obscureText: isPassword,
          controller: isPassword ? passwordController : usernameController,
          decoration: InputDecoration(
            labelText: label,
            icon: Icon(icon, color: Colors.blue),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildUploadButton(String label, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        // TODO: Add logic to upload certificate or photo
      },
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    );
  }
}
