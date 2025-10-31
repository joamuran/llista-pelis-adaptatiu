import 'package:exercici_disseny_responsiu_stateful/presentation/widgets/my_container_widget.dart';
import 'package:exercici_disseny_responsiu_stateful/presentation/widgets/my_list_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Exemple amb OrientationBuilder
  final List<Map<String, dynamic>> llistaItems = [
    {
      "titol": "Star Wars. Episode IV. A new Hope",
      "director": "George Lucas",
      "year": 1977,
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/8/87/StarWarsMoviePoster1977.jpg",
    },
    {
      "titol": "Star Wars. Episode V. Empire Strikes Back",
      "director": "Irvin Kershner",
      "year": 1981,
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/3/3f/The_Empire_Strikes_Back_%281980_film%29.jpg",
    },
    {
      "titol": "Star Wars. Episode VI. Return of the Jedi",
      "director": "Richard Marquand",
      "year": 1984,
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/b/b2/ReturnOfTheJediPoster1983.jpg",
    },
    {
      "titol": "Star Wars. Episode I, The Phantom Menace",
      "director": "George Lucas",
      "year": 1999,
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/4/40/Star_Wars_Phantom_Menace_poster.jpg",
    },
    {
      "titol": "Star Wars. Episode II. The Clone Attack.",
      "director": "George Lucas",
      "year": 2002,
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/3/32/Star_Wars_-_Episode_II_Attack_of_the_Clones_%28movie_poster%29.jpg",
    },
    {
      "titol": "Star Wars. Episode III. The Revenge of the Sith",
      "director": "George Lucas",
      "year": 2005,
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/9/93/Star_Wars_Episode_III_Revenge_of_the_Sith_poster.jpg",
    },
    {
      "titol": "Star Wars. Episode VII. The Force Awakens",
      "director": "JJ Abrams",
      "year": 2015,
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/a/a2/Star_Wars_The_Force_Awakens_Theatrical_Poster.jpg",
    },
    {
      "titol": "Star Wars. Episode VIII. The Last Jedi",
      "director": "Rian Johnson",
      "year": 2017,
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/7/7f/Star_Wars_The_Last_Jedi.jpg",
    },
    {
      "titol": "Star Wars. Episode IX. The Rise of Skywalker",
      "director": "JJ Abrams",
      "year": 2019,
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/a/af/Star_Wars_The_Rise_of_Skywalker_poster.jpg",
    },
  ];

  Map<String, dynamic>? currentFilm;

  _setFilm(Map<String, dynamic>? film) {
    setState(() {
      currentFilm = film;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Aquesta pantalla conté un scaffold amb la barra d'aplicacions i un cos
    return Scaffold(
      appBar: AppBar(title: const Text('OrientationBuilder Example')),
      // El body és un SafeArea: Widget que evita la interfície del sistema
      body: SafeArea(
        // Reacciona explícitament a canvis d’orientació del pare
        // Rebem orientation en el builder
        child: OrientationBuilder(
          builder: (context, orientation) {
            // isLandscape rep el valor de la comparació orientation==Orientation.landscape
            final isLandscape = orientation == Orientation.landscape;
            // Segons aquest, retornem un o altre arbre de widgets (ui declarativa)
            return isLandscape
                ? _sideBySideLayout(context, _setFilm)
                : _stackedLayout(context, _setFilm);
          },
        ),
      ),
    );
  }

  /* ============================
    Helpers de composició layout
    Els introduim com a mètodes del propi estat, per accedir a la informació necessària
   ============================ 
   */

  /// Disposició *top–bottom* (portrait): contenidor dalt, llista baix.
  ///
  Widget _stackedLayout(
    BuildContext context,
    Function(Map<String, dynamic>?) callback,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // El contenidor ocupa alçada intrínseca; la llista s’expandeix
          MyContainerWidget(film: currentFilm),
          const SizedBox(height: 12),
          Expanded(
            child: MyListWidget(items: llistaItems, callback: _setFilm),
          ),
        ],
      ),
    );
  }

  /// Disposició *side‑by‑side* (landscape): contenidor esquerra, llista dreta.
  Widget _sideBySideLayout(
    BuildContext context,
    Function(Map<String, dynamic>?) callback,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Flexible(flex: 2, child: MyContainerWidget(film: currentFilm)),
          const SizedBox(width: 12),
          Flexible(
            flex: 3,
            child: MyListWidget(items: llistaItems, callback: _setFilm),
          ),
        ],
      ),
    );
  }
}
