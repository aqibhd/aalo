import 'package:flutter/material.dart';

class AdditionalResource extends StatelessWidget {
  const AdditionalResource({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Additional Resource"),
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.1),
      ),
      body: Column(
        children: const [
          ListTile(
            title: Text("Version 1.0.2", style: TextStyle(color: Colors.amber)),
          ),
          ListTile(
            title: Text("Report Bugs", style: TextStyle(color: Colors.amber)),
          ),
          ListTile(
            title:
                Text("Follow Developer", style: TextStyle(color: Colors.amber)),
          ),
          ListTile(
            title:
                Text("Terms of Service", style: TextStyle(color: Colors.amber)),
          ),
          ListTile(
            title:
                Text("Privacy Policy", style: TextStyle(color: Colors.amber)),
          )
        ],
      ),
    );
  }
}
