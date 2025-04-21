import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakup_bridge/widgtes/custom_image.dart';
import 'package:flutter/services.dart'; // For loading assets
import 'package:flutter_pdfview/flutter_pdfview.dart'; // For displaying PDF files
import 'dart:io'; // For file handling
import 'package:path_provider/path_provider.dart';
import 'package:speakup_bridge/widgtes/custom_image_2.dart'; // For getting temporary directory

class LayoutCourses extends StatelessWidget {
  const LayoutCourses({Key? key}) : super(key: key);

  // Function to navigate to the Book Details screen
  void navigateToBookDetails(BuildContext context, String bookName, String bookLink) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetailsScreen(bookName: bookName, bookLink: bookLink)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Updated Books"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => navigateToBookDetails(context, "Book 1", 'book1.pdf'),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CustomImage2(
                    name: "book1",
                    height: 150.sp,
                  ),
                ),
              ),
              InkWell(
                onTap: () => navigateToBookDetails(context, "Book 2", 'book2.pdf'),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CustomImage2(
                    name: "book2",
                    height: 150.sp,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => navigateToBookDetails(context, "Book 3", 'book3.pdf'),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CustomImage2(
                    name: "book3",
                    height: 150.sp,
                  ),
                ),
              ),
              InkWell(
                onTap: () => navigateToBookDetails(context, "Book 4", 'book4.pdf'),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CustomImage2(
                    name: "book4",
                    height: 150.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Book Details Screen (PDF Viewer)
class BookDetailsScreen extends StatelessWidget {
  final String bookName;
  final String bookLink;

  const BookDetailsScreen({Key? key, required this.bookName, required this.bookLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookName),
      ),
      body: FutureBuilder<String>(
        future: _loadAsset(bookLink),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Failed to load the book.'));
          }

          return PDFView(
            filePath: snapshot.data ?? '',
          );
        },
      ),
    );
  }

  // Method to load asset
  Future<String> _loadAsset(String path) async {
    // Load the PDF file from assets
    final data = await rootBundle.load('assets/books/$path');  // Correct path to the PDF in your assets folder
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$path');
    await file.writeAsBytes(data.buffer.asUint8List());
    return file.path;  // Return the file path for the PDF
  }
}

class CustomImage extends StatelessWidget {
  final String name;
  final double height;

  const CustomImage({Key? key, required this.name, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$name.png', // Adjust the image path as needed
      height: height,
    );
  }
}
