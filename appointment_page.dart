import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(AppointmentPage());
}

class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  int step = 1;
  String _userName = '';
  String _userAge = '';
  String _userGender = '';
  String _userHeight = '';
  List<String> userSymptoms = [];
  List<dynamic> symptomSpecialistData = [];

  @override
  void initState() {
    super.initState();
    _botGreeting();
    _loadSymptomSpecialistData(); // Load symptom-specialist mapping data
  }

  Future<void> _loadSymptomSpecialistData() async {
    try {
      final String data =
          await rootBundle.loadString('assets/symptom_specialist_mapping.json');
      setState(() {
        symptomSpecialistData = json.decode(data)['symptomSpecialistMapping'];
      });
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }

  Future<void> _botGreeting() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: "Hello! How are you doing today?",
          isUser: false,
        ),
      );
    });
    _botProvideOptions();
  }

  void _botProvideOptions() {
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: "1. Doing Great\n2. Not feeling so good",
          isUser: false,
        ),
      );
    });
  }

  void _handleUserResponse(String text) async {
    _textController.clear();
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: text,
          isUser: true,
        ),
      );
    });

    text = _capitalizeFirstLetterOfEachWord(
        text); // Convert the first letter of each word to uppercase

    if (step == 1) {
      if (text == '1') {
        _botProvideOptions();
      } else if (text == '2') {
        _botAskName();
        step = 2;
      }
    } else if (step == 2) {
      _handleUserName(text);
    } else if (step == 3) {
      _handleUserAge(text);
    } else if (step == 4) {
      _handleUserGender(text);
    } else if (step == 5) {
      _handleUserHeight(text);
    } else if (step == 6) {
      _handleUserWeight(text);
    } else if (step == 7) {
      _handleUserSymptoms(text);
    }
  }

  String _capitalizeFirstLetterOfEachWord(String input) {
    List<String> words = input.split(' ');
    List<String> capitalizedWords = [];
    for (String word in words) {
      if (word.isNotEmpty) {
        capitalizedWords.add('${word[0].toUpperCase()}${word.substring(1)}');
      }
    }
    return capitalizedWords.join(' ');
  }

  void _botAskName() {
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: "Please enter your name.",
          isUser: false,
        ),
      );
    });
  }

  void _handleUserName(String name) {
    setState(() {
      _userName = name;
      _messages.insert(
        0,
        ChatMessage(
          text: "Your name is: $name",
          isUser: false,
        ),
      );
    });
    _botAskAge();
    step = 3;
  }

  void _botAskAge() {
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: "Please enter your age.",
          isUser: false,
        ),
      );
    });
  }

  void _handleUserAge(String age) {
    setState(() {
      _userAge = age;
      _messages.insert(
        0,
        ChatMessage(
          text: "Your age is: $age",
          isUser: false,
        ),
      );
    });
    _botAskGender();
    step = 4;
  }

  void _botAskGender() {
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: "Please enter your gender.",
          isUser: false,
        ),
      );
    });
  }

  void _handleUserGender(String gender) {
    setState(() {
      _userGender = gender;
      _messages.insert(
        0,
        ChatMessage(
          text: "Your gender is: $gender",
          isUser: false,
        ),
      );
    });
    _botAskHeight();
    step = 5;
  }

  void _botAskHeight() {
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: "Please enter your height (in cms).",
          isUser: false,
        ),
      );
    });
  }

  void _handleUserHeight(String height) {
    setState(() {
      _userHeight = height;
      _messages.insert(
        0,
        ChatMessage(
          text: "Your height is: $height cm",
          isUser: false,
        ),
      );
    });
    _botAskWeight();
    step = 6;
  }

  void _botAskWeight() {
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: "Please enter your weight (in kgs).",
          isUser: false,
        ),
      );
    });
  }

  void _handleUserWeight(String weight) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = {
      'Name': _userName,
      'Age': _userAge,
      'Gender': _userGender,
      'Height': _userHeight,
      'Weight': weight,
    };

    await prefs.setString('userDetails', json.encode(userJson));

    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text:
              "Your weight is: $weight kg. Thank you! Your information has been saved.",
          isUser: false,
        ),
      );
    });

    // Continue the conversation or perform other actions here
    _botAskSymptoms();
    step = 7;
  }

  void _botAskSymptoms() {
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text:
              "Great! Now can you tell me your symptoms? (Please separate multiple symptoms with commas)",
          isUser: false,
        ),
      );
    });
  }

  void _handleUserSymptoms(String symptomsText) {
    final List<String> symptoms = symptomsText.split(',');
    userSymptoms = symptoms.map((symptom) => symptom.trim()).toList();

    if (userSymptoms.isEmpty) {
      _botAskSymptoms(); // Ask again if no symptoms provided
    } else {
      final List<String> specialists = matchSymptomsToSpecialists(userSymptoms);
      _botRecommendSpecialists(specialists);
    }
  }

  List<String> matchSymptomsToSpecialists(List<String> symptoms) {
    List<String> specialists = [];

    for (String symptom in symptoms) {
      for (var mapping in symptomSpecialistData) {
        if (mapping['symptom'].toLowerCase() == symptom.toLowerCase()) {
          // Cast the elements in mapping['specialists'] to strings
          List<dynamic> specialistList = mapping['specialists'];
          specialists.addAll(
              specialistList.map((specialist) => specialist.toString()));
        }
      }
    }

    return specialists.toSet().toList(); // Remove duplicates
  }

  void _botRecommendSpecialists(List<String> specialists) {
    setState(() {
      if (specialists.isNotEmpty) {
        _messages.insert(
          0,
          ChatMessage(
            text:
                "Based on your symptoms, you may consider consulting the following specialist(s):\n${specialists.join(', ')}",
            isUser: false,
          ),
        );
      } else {
        _messages.insert(
          0,
          ChatMessage(
            text:
                "I couldn't find any specialists based on your symptoms. Please provide more details or consult a general physician.",
            isUser: false,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthcare Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.blue),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleUserResponse,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleUserResponse(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            // Wrap the message with an Expanded widget
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: isUser ? Colors.blueAccent : Colors.greenAccent,
                borderRadius: isUser
                    ? BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
              ),
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
