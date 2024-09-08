import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_to_app/App%20Cubit/Cubit.dart';
import 'package:to_to_app/App%20Cubit/States.dart';
import 'package:to_to_app/Components/Custom%20Bottom%20Navigation%20Bar.dart';
import 'package:to_to_app/Components/Custom%20Bottom%20Sheet.dart';
import 'package:to_to_app/Constants.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()..createDatabase(),
        child: BlocConsumer<TodoCubit , TodoStates>(
          listener: ( context, state) {
            if(state is InsertDataBaseState){
              Navigator.pop(context);
            }
          },
          builder: (context, state) {

            TodoCubit cubit = TodoCubit.get(context);

            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(
                  'To do list ',
                  style: TextStyle(fontSize: 25, fontFamily: defaultFont),
                ),
                backgroundColor: defaultColor,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(
                          title:cubit.titleController.text,
                          time:cubit.timeController.text,
                          date:cubit.dateController.text
                      );
                    }
                  } else {
                    scaffoldKey.currentState!.showBottomSheet((context) => Form(
                        key: formKey,
                        child: CustomBottomSheet())).closed.then((value) {
                      cubit.changeBottomSheet(
                          isShow: false,
                          icon: Icons.edit,
                      );

                    });
                    cubit.changeBottomSheet(
                        isShow: true,
                        icon: Icons.add
                    );
                  }
                  cubit.titleController.clear();
                  cubit.dateController.clear();
                  cubit.timeController.clear();
                },
                backgroundColor: defaultColor,
                child: Icon(
                    cubit.floatIcon
                ),
              ),
              bottomNavigationBar: CustomBottomNavigationBar(),
              body: ConditionalBuilder(
                condition: state is! DataBaseLoadingState,
                builder:  (context) => cubit.screens[cubit.currentIndex],
                fallback: (BuildContext context) =>
                const Center(child: CircularProgressIndicator(value: 0.5)),
              ),
            );
          },

        ),


    );

  }

}
