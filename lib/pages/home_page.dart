

import 'package:earthquake_app/providers/app_data_provider.dart';
import 'package:earthquake_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    Provider.of<AppDataProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QuAkeX"), centerTitle: true),
      body: Consumer<AppDataProvider>(
        builder: (context, provider, child) => provider.hasDataLoaded
            ? provider.earthQuakeModel!.features!.isEmpty
                  ? const Center(child: Text("No record found"))
                  : ListView.builder(
                      itemCount: provider.earthQuakeModel!.features!.length,
                      itemBuilder: (context, index) {
                        final data = provider
                            .earthQuakeModel!
                            .features![index]
                            .properties!;
                    
                        return Card(
                          color: Colors.green.shade300,
                          child: ListTile(
                            title: Text(data.place ?? data.title ?? "unknown"),
                            subtitle: FutureBuilder<String>(
                              future: getFormttedDateTime(
                                data.time!,
                                "EEE MM yyyy hh:mm a",
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('Please wait');
                                } else if (snapshot.hasError) {
                                  return const Text('');
                                } else {
                                  return Text(snapshot.data ?? '');
                                }
                              },
                            ),
                            trailing: Chip(
                              avatar: data.alert == null
                                  ? null
                                  : CircleAvatar(
                                      backgroundColor: provider.getAlertColor(
                                        data.alert!,
                                      ),
                                    ),
                              label: Text('${data.mag}'),
                            ),
                          ),
                        );
                      },
                    )
            : const Center(child: Text("Please wait")),
      ),
    );
  }
}
