import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_to_app/App%20Cubit/Cubit.dart';
import 'package:to_to_app/Components/Custom%20Text%20Form%20Field.dart';
import 'package:to_to_app/Constants.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {

  @override
  Widget build(BuildContext context) {
    TodoCubit cubit = TodoCubit.get(context);

    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              CustomTextFormField(
                controller: cubit.titleController,
                textInputType: TextInputType.text,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'Title must not be Empty';
                  }
                  return null;
                },
                label: 'Task Title',
                prefix: Icons.title,

              ),
              CustomTextFormField(
                onTap: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((value) {
                    cubit.timeController.text = value!.format(context);
                  });
                },
                controller: cubit.timeController,
                textInputType: TextInputType.datetime,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'Time must not be Empty';
                  }
                  return null;
                },
                label: 'Task Time',
                prefix: Icons.access_time_outlined,
              ),
              CustomTextFormField(
                onTap:(){
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse('2030-12-31'),
                  )  .then((value) {
                    cubit.dateController.text =DateFormat.yMMMd().format(value!);
                  });
                },
                controller: cubit.dateController,
                textInputType: TextInputType.text,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'Date must not be Empty';
                  }
                  return null;
                },
                label: 'Task Date',
                prefix: Icons.date_range_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
