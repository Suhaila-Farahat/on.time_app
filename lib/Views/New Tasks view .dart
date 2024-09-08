import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_to_app/App%20Cubit/Cubit.dart';
import 'package:to_to_app/App%20Cubit/States.dart';
import 'package:to_to_app/Components/Custom%20Tasks%20Builder.dart';

class NewTasksView extends StatelessWidget {
  const NewTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TodoCubit.get(context).newTasks;
        return CustomTasksBuilder(
          tasks: tasks,
        );
      },
    );
  }
}
