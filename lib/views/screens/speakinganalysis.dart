import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:record/record.dart' as rec;
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'dart:io';

class SpeechAnalysisScreen extends StatefulWidget {
  @override
  SpeechAnalysisScreenState createState() => SpeechAnalysisScreenState();
}

class SpeechAnalysisScreenState extends State<SpeechAnalysisScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "";
  String _selectedParagraph = "";
  final rec.AudioRecorder _audioRecorder = rec.AudioRecorder();
  String? _audioPath;
  String _feedback = "";
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<String> _paragraphs = [
    "Paragraph 1: Learning English is fun and useful. It helps in communication, career growth, and understanding different cultures. Practicing daily can significantly improve fluency and confidence.",
    "Paragraph 2: Reading books is one of the best ways to enhance knowledge and improve vocabulary. A person who reads regularly develops better comprehension skills and a deeper understanding of various subjects. It also enhances creativity and critical thinking abilities.",
    "Paragraph 3: Technology has revolutionized the way we live. From smartphones to artificial intelligence, it has made life more convenient. However, excessive use of technology can have negative impacts on mental health and social interactions. Maintaining a balance is essential for a healthy lifestyle."
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _selectedParagraph = _paragraphs[0];
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      if (await _audioRecorder.hasPermission()) {
        try {
          String path = '${Directory.systemTemp.path}/audio.m4a';
          await _audioRecorder.start(
            rec.RecordConfig(encoder: rec.AudioEncoder.aacLc),
            path: path,
          );
          setState(() => _isListening = true);
          _speech.listen(onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          });
        } catch (e) {
          print("Error starting recording: $e");
        }
      } else {
        print("Permission denied for recording");
      }
    }
  }

  Future<void> _stopListening() async {
    try {
      _speech.stop();
      String? path = await _audioRecorder.stop();
      setState(() {
        _isListening = false;
        _audioPath = path;
      });
      if (_audioPath != null) {
        _analyzeSpeech();
      }
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }

  Future<void> _analyzeSpeech() async {
    List<String> paragraphWords = _selectedParagraph
        .replaceAll(RegExp(r'[^\w\s]'), '') // Remove punctuation
        .toLowerCase()
        .split(' ');

    List<String> spokenWords = _text
        .replaceAll(RegExp(r'[^\w\s]'), '') // Remove punctuation
        .toLowerCase()
        .split(' ');

    List<String> originalWords = _selectedParagraph.split(' '); // Keep original formatting
    List<String> highlightedWords = [];

    for (int i = 0; i < originalWords.length; i++) {
      String originalWord = originalWords[i]; // Original word with punctuation
      String lowerWord = originalWord.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase(); // Remove punctuation for comparison

      if (spokenWords.contains(lowerWord)) {
        // Correct word, keep it black
        highlightedWords.add(originalWord);
      } else {
        // Incorrect word, make it red
        highlightedWords.add("<span style='color:red;'>$originalWord</span>");
      }
    }

    setState(() {
      _feedback = highlightedWords.join(' '); // Convert to formatted text
    });
  }

  void _playRecording() {
    if (_audioPath != null) {
      _audioPlayer.play(DeviceFileSource(_audioPath!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Read & Analyze")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select a Paragraph:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              DropdownButton<String>(
                isExpanded: true,
                value: _selectedParagraph,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedParagraph = newValue;
                    });
                  }
                },
                items: _paragraphs.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: 16)),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_selectedParagraph, style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 20),
              if (_audioPath != null) ...[
                Text("Play Recorded Audio:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _playRecording,
                  child: Text("Play Recording"),
                ),
                SizedBox(height: 20),
              ],
              Text("Speech Analysis Result:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Html(data: _feedback),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _isListening ? _stopListening : _startListening,
                  child: Text(_isListening ? "Stop & Analyze" : "Start Speaking"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}