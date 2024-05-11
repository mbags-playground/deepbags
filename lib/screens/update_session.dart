import 'package:deepbags/models/session.dart';
import 'package:deepbags/models/website.dart';
import 'package:deepbags/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:deepbags/widgets/button.dart';

class ManageWebsitesPage extends StatefulWidget {
  final SessionModel session;

  const ManageWebsitesPage({required this.session});

  @override
  _ManageWebsitesPageState createState() => _ManageWebsitesPageState();
}

class _ManageWebsitesPageState extends State<ManageWebsitesPage> {
  final _websiteNameController = TextEditingController();
  final _websiteMatchController = TextEditingController();
  List<WebsiteModel> _websites = [];

  @override
  void initState() {
    super.initState();
    _websites =
        widget.session.websites ?? []; // Initialize with existing websites
  }

  void _addWebsite() {
    final name = _websiteNameController.text;
    final match = _websiteMatchController.text;
    if (name.isEmpty || match.isEmpty) {
      return; // Show error message
    }
    setState(() {
      _websites.add(WebsiteModel(name: name, match: match));
      _websiteNameController.text = '';
      _websiteMatchController.text = '';
    });
  }

  void _removeWebsite(int index) {
    setState(() {
      _websites.removeAt(index);
    });
  }

  void _updateSessionWebsites() {
    // Update session websites (implementation depends on your persistence)
    // ...
    Navigator.pop(context); // Assuming pop on success
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Websites for ${widget.session.name}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Websites to be blocked/allowed (use * for wildcard):'),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: _websites.length,
                itemBuilder: (context, index) {
                  final website = _websites[index];
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${website.name} (${website.match})',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _removeWebsite(index),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            StyledInput(
              controller: _websiteNameController,
              label: 'Website Name',
              validators: [
                (label) => (value) {
                      if (value.isEmpty) {
                        return 'Please enter a website name.';
                      }
                      return null;
                    },
              ],
            ),
            SizedBox(height: 10.0),
            StyledInput(
              controller: _websiteMatchController,
              label: 'Website Match Pattern',
              validators: [
                (label) => (value) {
                      if (value.isEmpty) {
                        return 'Please enter a match pattern.';
                      }
                      return null;
                    },
              ],
            ),
            SizedBox(height: 20.0),
            StyledButton(
              onPressed: _addWebsite,
              child: Text('Add Website'),
            ),
            SizedBox(height: 10.0),
            StyledButton(
              onPressed: _updateSessionWebsites,
              child: Text('Update Session Websites'),
            ),
          ],
        ),
      ),
    );
  }
}
