import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart'; 

Widget buildInputField(IconData icon, String label, String texthint) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF6D9BA6))),
          SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              hintText: texthint,
              filled: true,
              fillColor: Colors.grey.shade100,
              prefixIcon: Icon(icon, color: Color.fromARGB(255, 171, 225, 245)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
