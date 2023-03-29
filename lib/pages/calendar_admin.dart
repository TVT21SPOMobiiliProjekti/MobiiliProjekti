import 'package:flutter/material.dart';
import '../models/calendar_model.dart';

class CalendarAdmin extends StatefulWidget {
  const CalendarAdmin({Key? key}) : super(key: key);

  @override
  State<CalendarAdmin> createState() => _CalendarAdminState();
} 

class _CalendarAdminState extends State<CalendarAdmin> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: const CalendarModel(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: const Icon(Icons.add),
      )
     
    );
  } 
}