import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_to_app/App%20Cubit/States.dart';
import 'package:to_to_app/Views/Archived%20Tasks%20view.dart';
import 'package:to_to_app/Views/Done%20Tasks%20view.dart';
import 'package:to_to_app/Views/New%20Tasks%20view%20.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(InitialState());
  static TodoCubit get(context) => BlocProvider.of(context);
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  Database? database;
  List<Widget> screens = [
    NewTasksView(),
    DoneTasksView(),
    ArchivedTasksView()
  ];
  List<String> titles = [
    ' New',
    ' Done',
    'Archived ',
  ];
  var currentIndex = 0;

  bool isBottomSheetShown = false;
  IconData floatIcon = Icons.edit;

  List<Map> newTasks =[];
  List<Map> doneTasks =[];
  List<Map> archivedTasks =[];

  void changeIndexBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  void changeBottomSheet({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    floatIcon = icon;
    emit(ChangeBottomSheetState());
  }

  void createDatabase() async{
     await openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) {
      print('Database Created');
      database
          .execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((error) {
        print('Error when creating table ${error.toString()}');
      });
    },
        onOpen: (database) {
          getDataBase(database);
         print('Database Opened');

    },
    ).then((value)
    {
      database =value;
      emit(CreateDataBaseState());
    });
  }

  void insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database?.transaction((txn) {
      txn.rawInsert(
              'INSERT INTO Tasks(title, date, time, status) VALUES( "$title", "$date", "$time", "new")'
      ).then((value)
      {
        print('$value Inserted successfully');
        emit(InsertDataBaseState());
        getDataBase(database);
      }).catchError((error) {
        print('Error when inserting New Record ${error.toString()}');
      });
      return Future(() => null);

    }
    );
  }

  void getDataBase(database) async {

    newTasks = [];
    doneTasks =[];
    archivedTasks =[];

    emit(DataBaseLoadingState ());
    database.rawQuery('SELECT * FROM Tasks').then((value)
    {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        }
        else if (element['status'] == 'done'){
          doneTasks.add(element);
        }
        else {
          archivedTasks.add(element);
        }
      });

      emit(GetDataBaseState());

    });
  }


  void updateData({
    required String status ,
    required int id ,
}) async {
    database?.rawUpdate(
        'UPDATE Tasks SET status = ? WHERE id = ?',
        ['$status', id]
    ).then((value) {
      getDataBase(database);
      emit(UpdateDataBaseState());
    });

  }



  void deleteData({
    required int id ,
}) async {
    database?.rawDelete(
        'DELETE FROM Tasks WHERE id = ? ',[id]).then((value) {
      getDataBase(database);
      emit(UpdateDataBaseState());
    });

  }

}
