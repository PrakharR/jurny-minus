import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final TextEditingController titleController =
                  TextEditingController();
              final TextEditingController descriptionController =
                  TextEditingController();

              return AlertDialog(
                title: Text('Create a new trip'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                      maxLength: 100,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      inputFormatters: [LengthLimitingTextInputFormatter(1000)],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      String title = titleController.text;
                      String description = descriptionController.text;

                      // TODO(prakharrathi): Perform create trip action.
                      Navigator.of(context).pop();
                    },
                    child: Text('Create'),
                  ),
                ],
              );
            },
          );
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
