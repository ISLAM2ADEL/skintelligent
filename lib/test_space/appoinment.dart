import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Appointment',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AppointmentScreen(),
    );
  }
}

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});
  static const String id = 'AppointmentScreen';

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String selectedLocation = 'Cairo';
  List<String> locations = ['Cairo', 'Giza', 'Alexandria', 'Helwan'];

  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Ahmed Khaled',
      'location': 'Cairo',
      'summary': 'Expert in skin diseases and laser treatments.',
      'availableDates': [DateTime.now(), DateTime.now().add(Duration(days: 2))]
    },
    {
      'name': 'Dr. Sara Ali',
      'location': 'Giza',
      'summary': 'Dermatologist specialized in acne and eczema treatment.',
      'availableDates': [DateTime.now(), DateTime.now().add(Duration(days: 3))]
    },
    {
      'name': 'Dr. Mohamed Hassan',
      'location': 'Alexandria',
      'summary': 'Skin specialist focusing on hair loss and scalp care.',
      'availableDates': [DateTime.now().add(Duration(days: 1))]
    },
    {
      'name': 'Dr. Rana Mahmoud',
      'location': 'Helwan',
      'summary': 'Expert in cosmetic dermatology and skin rejuvenation.',
      'availableDates': [
        DateTime.now(),
        DateTime.now().add(const Duration(days: 4))
      ]
    },
  ];

  void bookAppointment(String doctorName, DateTime date) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Appointment booked with $doctorName on ${DateFormat.yMMMd().format(date)}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredDoctors = doctors
        .where((doctor) => doctor['location'] == selectedLocation)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Book an Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Dropdown
            const Text('Select Location:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedLocation,
              items: locations.map((String loc) {
                return DropdownMenuItem<String>(value: loc, child: Text(loc));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedLocation = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            // Doctor List
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = filteredDoctors[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doctor['name'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text(doctor['summary'],
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey)),
                          const SizedBox(height: 10),
                          const Text('Available Dates:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Column(
                            children:
                                doctor['availableDates'].map<Widget>((date) {
                              return ListTile(
                                title: Text(DateFormat.yMMMd().format(date)),
                                trailing: ElevatedButton(
                                  onPressed: () =>
                                      bookAppointment(doctor['name'], date),
                                  child: const Text('Book'),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
