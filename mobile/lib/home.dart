import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO(prakharrathi): Navigate to the create trip page.
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text('Your trips')),
      body: ListView(
        children: const [
          TripListItem(
            id: '1',
            title: 'Trip to Paris',
            description: 'A wonderful trip to Paris.',
          ),
          TripListItem(
            id: '2',
            title: 'Trip to New York',
            description: 'An exciting trip to New York.',
          ),
          TripListItem(
            id: '3',
            title: 'Trip to Tokyo',
            description: 'An amazing trip to Tokyo.',
          ),
        ],
      ),
    );
  }
}

class TripListItem extends StatelessWidget {
  const TripListItem({
    super.key,
    required this.id,
    required this.title,
    required this.description,
  });

  final String id;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      onTap: () {
        // TODO: Navigate to the trip page.
      },
    );
  }
}
