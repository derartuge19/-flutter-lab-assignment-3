import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/album_bloc.dart';
import '../models/photo.dart';

class AlbumListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Album Gallery",
          style: TextStyle(
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 2,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          if (state is AlbumError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.white70),
              ),
            );
          }
          if (state is AlbumLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final album = state.albums[index];
                final photo = state.photos.firstWhere(
                  (p) => p.albumId == album.id,
                  orElse: () => Photo(albumId: 0, title: '', thumbnailUrl: ''),
                );
                
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xFF282828),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => context.go('/detail/${album.id}'),
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.orange.withOpacity(0.1),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Image.network(
                                  photo.thumbnailUrl,fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      color: Colors.grey[800],
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        color: Colors.white38,
                                        size: 48,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  album.title,
                                  style: Theme.of(context).textTheme.titleLarge,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.album,
                                      color: Colors.orange,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "#${album.id}",
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Text(
              "Press refresh",
              style: TextStyle(color: Colors.white70),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.read<AlbumCubit>().fetchAlbums(),
        label: Text("Refresh"),
        icon: Icon(Icons.refresh),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
