import 'package:deepbags/database/repositories/session_repository.dart';
import 'package:deepbags/widgets/loading.dart';
import 'package:flutter/material.dart';

class AllSessions extends StatefulWidget {
  const AllSessions({super.key});

  @override
  State<AllSessions> createState() => _AllSessionsState();
}

class _AllSessionsState extends State<AllSessions> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SessionRepository().listFromStorage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  var session = snapshot.data?[index];
                  return ListTile(title: Text(session?.name ?? ""));
                });
          }
          return LoadingWidget();
        });
  }
}
