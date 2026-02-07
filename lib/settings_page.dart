import 'package:earthquake_app/providers/app_data_provider.dart';
import 'package:earthquake_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"),
      centerTitle: true,
      ),

      body: Consumer<AppDataProvider>(
        
        builder: (context, provider, child) => ListView(
          padding: EdgeInsets.all(15.0),
          children: [
            Text(
              "Time Settings",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            Card(
              elevation: 3,
              color: Colors.blueGrey.shade200,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    title: Text("Strat Time"),
                    subtitle: Text(provider.startTime),
                    trailing: IconButton(
                      onPressed: () async {
                        final date = await selectDate();
                        if (date != null) {
                          provider.setStartTime(date);
                        }
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                  ),
                  ListTile(
                    title: Text("End Time"),
                    subtitle: Text(provider.endTime),
                    trailing: IconButton(
                      onPressed: () async {
                        final date = await selectDate();
                        if (date != null) {
                          provider.setEndTime(date);
                        }
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade50,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      provider.getEarthQuakedata();
                      showMsg(context, 'Times are updated');
                    },
                    child: Text('Update Time Changes'),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          SizedBox(height: 20,),
            Text(
              "Location Settings",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Card(
              child: SwitchListTile(
                
                title: Text(provider.currentCity ?? "Your city is Unknown"),
                subtitle: provider.currentCity == null
                    ? null
                    : Text(
                        'Earthquake data will be shown within ${provider.maxRadiusKm} Km radius from ${provider.currentCity}',
                      ),
                value: provider.shouldUseLocation,
                onChanged: (value)async {
                  EasyLoading.show(status: 'Getting Location..');
                  await provider.setLocation(value);
                  EasyLoading.dismiss();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> selectDate() async {
    final dt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (dt != null) {
      return getFormttedDateTime(dt.millisecondsSinceEpoch);
    }
    return null;
  }
}
