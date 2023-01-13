import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/shared/cubit/cubit.dart';
import 'package:to_do_app/shared/cubit/states.dart';
import 'package:to_do_app/widgets/no_tasks.dart';

import '../../widgets/buildTaskItem.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return (tasks.isEmpty)
            ? const NoTasks()
            : ListView.separated(
                itemBuilder: (context, index) {
                  return BuildTaskItem(model: tasks[index]);
                },
                separatorBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey[300],
                  );
                },
                itemCount: tasks.length);
      },
    );
  }
}
