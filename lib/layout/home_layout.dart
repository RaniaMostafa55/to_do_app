import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/shared/cubit/cubit.dart';
import 'package:to_do_app/shared/cubit/states.dart';
import 'package:to_do_app/widgets/default_text_field.dart';

class HomeLayout extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertToDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(titleController.text,
                        dateController.text, timeController.text);
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        elevation: 20,
                        (context) => Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DefaultTextField(
                                      type: TextInputType.text,
                                      controller: titleController,
                                      message: "Title required",
                                      hint: "Title",
                                      icon: Icons.title),
                                  const SizedBox(height: 8),
                                  DefaultTextField(
                                      type: TextInputType.datetime,
                                      onTap: () {
                                        // print("Tapped");
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timeController.text =
                                              value!.format(context);
                                          // print("Time is ${value.format(context)}");
                                        });
                                      },
                                      controller: timeController,
                                      message: "Time Required",
                                      hint: "Time",
                                      icon: Icons.punch_clock),
                                  const SizedBox(height: 8),
                                  DefaultTextField(
                                      controller: dateController,
                                      type: TextInputType.datetime,
                                      onTap: () {
                                        // print("Tapped");

                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2010),
                                          lastDate: DateTime(2050),
                                        ).then((value) {
                                          dateController.text = DateFormat()
                                              .add_yMMMd()
                                              .format(value!);

                                          // print("Time is ${value.format(context)}");
                                        });
                                      },
                                      message: "Date Required",
                                      hint: "Date",
                                      icon: Icons.calendar_month)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShown: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShown: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.done_outline), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: "Archived"),
              ],
            ),
            body: state is AppGetDatabaseLoadingState
                ? const Center(child: CircularProgressIndicator())
                : cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }

  Future<String> getName() async {
    return "Ahmed Ali";
  }
}
