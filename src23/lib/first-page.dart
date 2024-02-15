// ignore_for_file: avoid_print, use_key_in_widget_constructors, file_names, todo, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:robbinlaw/widgets/mysnackbar.dart';

// Do not change the structure of this files code.
// Just add code at the TODO's.

final formKey = GlobalKey<FormState>();

// We must make the variable firstName nullable.
String? firstName;
final TextEditingController textEditingController = TextEditingController();

class MyFirstPage extends StatefulWidget {
  @override
  MyFirstPageState createState() => MyFirstPageState();
}

class MyFirstPageState extends State<MyFirstPage> {
  bool enabled = false;
  int timesClicked = 0;
  String msg1 = 'Click Me';
  String msg2 = '';
  int? savedTimesClicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A2 - User Input'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Enable Buttons: '),
              Switch(
                value: enabled,
                onChanged: (value) {
                  setState(() {
                    enabled = value;
                    if (!enabled && timesClicked > 0) {
                      // Save the current count when the switch is turned off
                      savedTimesClicked = timesClicked;
                    } else if (enabled && savedTimesClicked != null) {
                      // Restore the count when the switch is turned back on
                      timesClicked = savedTimesClicked!;
                      msg1 = 'Clicked $timesClicked times';
                    }
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: enabled,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        timesClicked++;
                        msg1 = 'Clicked $timesClicked times';
                      });
                    },
                    child: Text(msg1),
                  ),
                ),
              ),
              Visibility(
                visible: enabled,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        timesClicked = 0;
                        msg1 = 'Click Me';
                      });
                    },
                    child: Text('Reset'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Icon(Icons.hourglass_top),
                      Expanded(
                        child: TextFormField(
                          controller: textEditingController,
                          maxLength: 20,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            suffixIcon: Icon(Icons.check_circle),
                            helperText: 'Min 1, Max 20',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Min  1 character';
                            } else if (value.length < 1 || value.length > 20) {
                              return 'Must be between  1 and  20 characters';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            firstName = value;
                          },
                          onChanged: (text) {
                            if (text.length <= 20) {
                              textEditingController.text = text;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          final snackBar = SnackBar(
                            content: Text('Hey There, Your name is $firstName'),
                            duration: Duration(seconds: 5),
                            action: SnackBarAction(
                              label: 'Print',
                              onPressed: () {
                                print('$firstName');
                              },
                              textColor: Colors.white,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
