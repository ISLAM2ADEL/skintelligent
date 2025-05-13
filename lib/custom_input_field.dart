import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomInputField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;
  String? _selectedGender;

  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final RegExp _phoneRegex = RegExp(r'^\d+$');

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (widget.labelText == "Gender") {
      return Container(
        width: size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gender',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              hint: Text(widget.hintText),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                  widget.controller?.text = value ?? '';
                });
              },
              items: ['Male', 'Female']
                  .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              ))
                  .toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select gender';
                }
                return null;
              },
            ),
          ],
        ),
      );
    }

    if (widget.labelText == "Date of Birth") {
      return Container(
        width: size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date of Birth',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: widget.controller,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'yyyy/mm/dd',
                suffixIcon: const Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      "${pickedDate.year}/${_twoDigits(pickedDate.month)}/${_twoDigits(pickedDate.day)}";
                  setState(() {
                    widget.controller?.text = formattedDate;
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select date of birth';
                }
                return null;
              },
            ),
          ],
        ),
      );
    }

    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.labelText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            obscureText: (widget.obscureText && _obscureText),
            keyboardType: widget.labelText == "Email"
                ? TextInputType.emailAddress
                : widget.labelText.toLowerCase() == "phone number"
                ? TextInputType.number
                : TextInputType.text,
            decoration: InputDecoration(
              isDense: widget.isDense ?? false,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon
                  ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.remove_red_eye
                      : Icons.visibility_off_outlined,
                  color: Colors.black54,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
                  : null,
              suffixIconConstraints: (widget.isDense != null)
                  ? const BoxConstraints(maxHeight: 33)
                  : null,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (textValue) {
              if (textValue == null || textValue.isEmpty) {
                return 'Required!';
              }

              if (widget.labelText == "Email" &&
                  !_emailRegex.hasMatch(textValue)) {
                return 'Please enter a valid email';
              }

              if (widget.labelText.toLowerCase() == "phone number" &&
                  !_phoneRegex.hasMatch(textValue)) {
                return 'Please enter a valid phone number';
              }

              return null;
            },
            controller: widget.controller,
          ),
        ],
      ),
    );
  }
}
