import 'package:flutter/material.dart';

class MyContainerWidget extends StatelessWidget {
  const MyContainerWidget({super.key, this.film});

  final Map<String, dynamic>? film;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: film == null
            ? const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Selecciona una pel·lícula de la llista'),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, // 👈 perquè la portada ocupe tot l’ample
                children: [
                  // 🔹 Portada a dalt (ample complet). Canvia l’aspect ratio al teu gust.
                  // 16/9 sol quedar bé per a “banner”; si vols look de pòster usa 2/3 i afegeix un límit d’alçada.
                  _CoverFullWidth(cover: (film!['cover'] as String?)?.trim()),

                  // 🔹 Textos i accions, amb padding intern
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // evita overflows verticals
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (film!['titol'] ?? '—').toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${film!['director'] ?? '—'} · ${film!['year'] ?? ''}',
                        ),
                        // Aquí podries afegir botons (Acció / Neteja) si vols
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _CoverFullWidth extends StatelessWidget {
  const _CoverFullWidth({required this.cover});
  final String? cover;

  @override
  Widget build(BuildContext context) {
    final placeholderColor = Theme.of(
      context,
    ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5);

    // Si vols “pòster” alt, posa aspectRatio: 2/3 i limita alçada amb ConstrainedBox.
    // Si vols “banner”, deixa 16/9.
    const aspect = 16 / 9;

    final Widget child = (cover == null || cover!.isEmpty)
        ? Container(
            color: placeholderColor,
            child: const Icon(Icons.image_not_supported),
          )
        : Image.network(
            cover!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            loadingBuilder: (c, w, p) => p == null
                ? w
                : const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
          );

    return SizedBox(
      width: double.infinity,
      child: AspectRatio(aspectRatio: aspect, child: child),
    );

    // 👉 Si prefereixes look “pòster” sense que es faça massa alt:
    // return ConstrainedBox(
    //   constraints: const BoxConstraints(maxHeight: 240), // límit d’alçada
    //   child: SizedBox(
    //     width: double.infinity,
    //     child: AspectRatio(aspectRatio: 2/3, child: child),
    //   ),
    // );
  }
}
