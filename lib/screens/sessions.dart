import 'package:deepbags/database/database.dart';
import 'package:deepbags/models/session.dart';
import 'package:flutter/material.dart';

class SessionsListPage extends StatefulWidget {
  const SessionsListPage({super.key});

  @override
  _SessionsListPageState createState() => _SessionsListPageState();
}

class _SessionsListPageState extends State<SessionsListPage> {
  Future<List<SessionModel>>? _sessions;

  @override
  void initState() {
    super.initState();
    _sessions = _fetchSessions();
  }

  Future<List<SessionModel>> _fetchSessions() async {
    var sessions = await sessionRepository.listFromStorage();
    return sessions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessions'),
      ),
      body: FutureBuilder<List<SessionModel>>(
        future: _sessions,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final sessions = snapshot.data!;
          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return SessionListItem(session: session);
            },
          );
        },
      ),
    );
  }
}

class SessionListItem extends StatelessWidget {
  final SessionModel session;

  const SessionListItem({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(session.name),
      subtitle: Text('Duration: ${session.lengthInMinutes} minutes'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Navigate to session details page (implementation depends on your app)
      },
    );
  }
}
