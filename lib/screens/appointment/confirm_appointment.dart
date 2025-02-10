import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/cubit/appointment_cubit/appointment_cubit.dart';
import '../../const/const.dart';

class ConfirmAppointment extends StatelessWidget {
  ConfirmAppointment({super.key});
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TimeOfDay _timeOfDay = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide.none,
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: height * .9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: height * .4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 115,
                          backgroundColor: color6,
                        ),
                        const CircleAvatar(
                          radius: 105,
                          backgroundColor: color8,
                        ),
                        const CircleAvatar(
                          radius: 90,
                          backgroundColor: color5,
                        ),
                        Positioned(
                          bottom:
                              0, // Adjusts the image to be positioned correctly
                          child: Image.asset(
                            "${path}removed doctor.png",
                            height: height * .3, // Adjust height as needed
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * .37,
                    width: width,
                    decoration: BoxDecoration(
                      color: color1,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * .07,
                        vertical: height * .03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Mohammed Hanafy",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            "400 EGP",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.description_outlined,
                                size: 24,
                              ),
                              Text(
                                "Previous Descreption",
                                style: TextStyle(
                                  color: font1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "7 years of experlence in hoher wrdlogy department aiso surgery spedulist simply dummy 1ex of the prating and",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              color: font2,
                              fontSize: 15,
                            ),
                          ),
                          InkWell(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: color7,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "Get Appointment",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: font3,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: height * .25,
                                    width: width,
                                    color: color7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        const Text(
                                          'Choose Date and Time',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * .7,
                                          child: TextField(
                                            controller: _dateController,
                                            decoration: const InputDecoration(
                                              labelText: 'Date',
                                              filled: true,
                                              prefixIcon: Icon(
                                                Icons.calendar_today_outlined,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            readOnly: true,
                                            onTap: () {
                                              _selectDate(context: context);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * .7,
                                          child: TextField(
                                            controller: _timeController,
                                            decoration: const InputDecoration(
                                              labelText: 'Time',
                                              filled: true,
                                              prefixIcon: Icon(
                                                Icons.access_time_rounded,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            readOnly: true,
                                            onTap: () {
                                              _selectTime(context: context);
                                            },
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                                child: const Text('cancel'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                }),
                                            ElevatedButton(
                                                child: const Text('Submit'),
                                                onPressed: () {
                                                  print(_dateController
                                                      .toString());
                                                  print(_timeController
                                                      .toString());
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate({required BuildContext context}) async {
    final cubit = context.read<AppointmentCubit>();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      cubit.updateDate();
      _dateController.text = picked.toString().split(" ")[0];
    }
  }

  Future<void> _selectTime({required BuildContext context}) async {
    final cubit = context.read<AppointmentCubit>();
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (picked != null) {
      cubit.updateTime(); // Update cubit state
      _timeController.text =
          "${picked.hourOfPeriod}:${picked.minute} ${picked.period == DayPeriod.am ? 'AM' : 'PM'}"; // Format time
    }
  }
}
