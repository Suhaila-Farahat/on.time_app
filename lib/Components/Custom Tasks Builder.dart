import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:to_to_app/Components/Custom%20Divider.dart';
import 'package:to_to_app/Components/Custom%20Task%20Item.dart';
import 'package:to_to_app/Constants.dart';

Widget CustomTasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => CustomTaskItem(tasks[index], context),
          separatorBuilder: (context, index) => CustomDivider(),
          itemCount: tasks.length
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 45,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'No Tasks Yet , Please Add Some Tasks ',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                fontFamily: defaultFont,
                letterSpacing: 1

              ),
            ),
          ],
        ),
      ),
    );
