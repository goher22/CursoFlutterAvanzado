import 'package:flutter/material.dart';

import '../models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: "1", name: "Metallica", votes: 5),
    Band(id: "2", name: "Queen", votes: 1),
    Band(id: "3", name: "Heroes del silencio", votes: 2),
    Band(id: "4", name: "Bon Jovi", votes: 5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BandName",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => _bandTIle(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        elevation: 1,
        backgroundColor: Colors.blue[100],
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  ListTile _bandTIle(Band band) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(
          band.name.substring(0, 2),
        ),
      ),
      title: Text(band.name),
      trailing: Text(
        '${band.votes}',
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      onTap: () {
        print(band.name);
      },
    );
  }
}
