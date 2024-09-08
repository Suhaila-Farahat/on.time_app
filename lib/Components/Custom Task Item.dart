import 'package:flutter/material.dart';
import 'package:to_to_app/App%20Cubit/Cubit.dart';
import 'package:to_to_app/Constants.dart';

Widget CustomTaskItem( Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: defaultColor,
              child: Text(
                '${model['id']}',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: defaultFont,
                    fontSize: 25
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${model['title']}',
                          style:
                              TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                color: defaultColor
                              ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            TodoCubit.get(context)
                                .updateData(status: 'done', id: model['id']);
                          },
                          icon: Icon(
                            Icons.check_box,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () {
                            TodoCubit.get(context)
                                .updateData(status: 'archived', id: model['id']);
                          },
                          icon: Icon(
                            Icons.archive,
                            color: Colors.black45,
                          )),

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'time : ${model['time']}',
                          style: TextStyle(color: defaultColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'date : ${model['date']}',
                          style: TextStyle(color: defaultColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
      onDismissed: (direction) {
        TodoCubit.get(context).deleteData(id: model['id']);
      },
    );
