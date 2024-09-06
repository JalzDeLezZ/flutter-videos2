import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});


  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Comprando palomitas... 🍿',
      'Alistando la cama... 🛏️',
      'Llamando a mi novia... 📞',
      'Esperando a que empiece la película... 🎬',
      'Esto no es un mensaje subliminal... 🤫'
    ];

    return Stream.periodic(const Duration(seconds: 1), (int index) {
      return messages[index];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Obteniendo películas...'),
        const SizedBox(height: 20),
        const CircularProgressIndicator(strokeWidth: 2),
        const SizedBox(height: 20),
        StreamBuilder(
          stream: getLoadingMessages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) return Text(snapshot.data.toString());
            return const Text('Cargando...');
          },
        )
      ],
    ));
  }
}
