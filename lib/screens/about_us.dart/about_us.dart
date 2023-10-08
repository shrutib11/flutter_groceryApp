import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Text(
              "We're a small, tight-knit team focused on bulding and empowering and easy to use andriod application. We are dedicated to fulfill the clients need.our team consits of",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListItem(text: 'shrutibhalodia11@gmail.com'),
                  const SizedBox(
                    height: 5,
                  ),
                  ListItem(text: 'bhadiyadraharikrishna@gmail.com'),
                  const SizedBox(
                    height: 5,
                  ),
                  ListItem(text: 'dhruvantala789@gmail.com'),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String text;

  ListItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 17.0, // Adjust this width as needed
                height: 17.0, // Adjust this height as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red
                      .withOpacity(0.8), // You can change the color here
                ),
              ),
              const Icon(
                Icons.circle,
                size: 10.0,
                color: Colors.white, // You can change the color here
              ),
            ],
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
