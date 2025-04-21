import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EnglishLearningChatbot extends StatefulWidget {
  @override
  _EnglishLearningChatbotState createState() => _EnglishLearningChatbotState();
}

class _EnglishLearningChatbotState extends State<EnglishLearningChatbot> {
  SpeechToText _speechToText = SpeechToText();
  FlutterTts _flutterTts = FlutterTts();
  bool _speechEnabled = false;
  bool _isListening = false;
  String _lastWords = "";
  TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> _chatMessages = [];
  bool _askedSource = false;
  bool _askedInterest = false;
  String? _userInterest;
  String apiKey = " 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"; // Securely store this

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _initTTS();
    _askSource();
  }

  /// Initialize Speech-to-Text
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Initialize Text-to-Speech
  void _initTTS() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
  }

  void _askSource() {
    _addBotMessage("Where did you hear about this app?");
  }

  /// Start Listening (Voice Input)
  void _startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(onResult: _onSpeechResult);
      setState(() => _isListening = true);
    }
  }

  /// Stop Listening
  void _stopListening() async {
    await _speechToText.stop();
    setState(() => _isListening = false);
    _processMessage(_lastWords);
  }

  /// Handle Speech Result
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  /// Process User's Message
  void _processMessage(String? message) {
    if (message == null || message.trim().isEmpty) return;
    _addUserMessage(message);

    if (!_askedSource) {
      _askedSource = true;
      _addBotMessage("Thanks! What are you interested in? (e.g., sports, movies, technology)");
    } else if (!_askedInterest) {
      _userInterest = message;
      _askedInterest = true;
      _addBotMessage("Great! Let's talk about $_userInterest. What would you like to discuss?");
    } else {
      _fetchResponseFromAI(message);
    }
  }

  /// Fetch Response from OpenAI
  void _fetchResponseFromAI(String message) async {
    try {
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "Talk to the user about their interest in $_userInterest and correct grammar mistakes."},
            {"role": "user", "content": message}
          ]
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String reply = data["choices"][0]["message"]["content"] ?? "Sorry, I didn't understand that.";
        _addBotMessage(reply);
      } else {
        _addBotMessage("Error: ${response.statusCode}. Please try again later.");
      }
    } catch (e) {
      _addBotMessage("An error occurred: $e");
    }
  }

  /// Add Bot Message
  void _addBotMessage(String message) {
    setState(() {
      _chatMessages.add({"sender": "bot", "message": message});
    });
    _flutterTts.speak(message);
  }

  /// Add User Message
  void _addUserMessage(String message) {
    setState(() {
      _chatMessages.add({"sender": "user", "message": message});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("English Learning Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                var chat = _chatMessages[index];
                bool isUser = chat["sender"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      chat["message"],
                      style: TextStyle(color: isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: Colors.blue),
                  onPressed: _isListening ? _stopListening : _startListening,
                ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: (message) {
                      _processMessage(message);
                      _textController.clear();
                    },
                    decoration: InputDecoration(hintText: "Type a message..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    _processMessage(_textController.text);
                    _textController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
