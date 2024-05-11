import 'package:deepbags/models/session.dart';
import 'package:deepbags/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:deepbags/widgets/button.dart';

// Assuming you have a Session model with relevant fields

class AddSessionPage extends StatefulWidget {
  @override
  _AddSessionPageState createState() => _AddSessionPageState();
}

class _AddSessionPageState extends State<AddSessionPage> {
  final _nameController = TextEditingController();
  final _durationController = TextEditingController();
  var _filterMode = FilterMode.block; // Assuming FilterMode enum exists

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Session'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            StyledInput(
              controller: _nameController,
              label: 'Session Name',
              validators: [
                (label) => (value) {
                      if (value.isEmpty) {
                        return 'Please enter a name for the session.';
                      }
                      return null;
                    },
              ],
            ),
            SizedBox(height: 20.0),
            StyledInput(
              controller: _durationController,
              label: 'Session Duration (minutes)',
              inputType: InputType.number,
              validators: [
                (label) => (value) {
                      if (value.isEmpty) {
                        return 'Please enter a duration.';
                      }
                      try {
                        int duration = int.parse(value);
                        if (duration <= 0) {
                          return 'Duration must be positive.';
                        }
                      } catch (e) {
                        return 'Invalid duration.';
                      }
                      return null;
                    },
              ],
            ),
            SizedBox(height: 20.0),
            DropdownButtonFormField<FilterMode>(
              value: _filterMode,
              items: FilterMode.values.map((FilterMode mode) {
                return DropdownMenuItem<FilterMode>(
                  value: mode,
                  child: Text(mode.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) => setState(() => _filterMode = value!),
              hint: Text('Filter Mode'),
            ),
            SizedBox(height: 20.0),
            StyledButton(
              onPressed: () {
                // Validate and create session object
                final name = _nameController.text;
                final duration = int.tryParse(_durationController.text);
                if (name.isEmpty || duration == null || duration <= 0) {
                  return; // Show error message
                }
                final session = SessionModel(
                  name: name,
                  lengthInMinutes: duration,
                  mode: _filterMode,
                  // Add websites if needed
                );

                // Save session (implementation depends on your persistence)
                // ...

                // Handle success or error
                Navigator.pop(context); // Assuming pop on success
              },
              child: Text('Save Session'),
            ),
          ],
        ),
      ),
    );
  }
}
