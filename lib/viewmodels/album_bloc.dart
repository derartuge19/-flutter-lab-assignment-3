import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/album.dart';
import '../models/photo.dart';
import '../data/api_service.dart';

abstract class AlbumState {}
class AlbumInitial extends AlbumState {}
class AlbumLoading extends AlbumState {}
class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  final List<Photo> photos;
  AlbumLoaded(this.albums, this.photos);
}
class AlbumError extends AlbumState {
  final String message;
  AlbumError(this.message);
}

class AlbumCubit extends Cubit<AlbumState> {
  final ApiService apiService;
  AlbumCubit(this.apiService) : super(AlbumInitial());

  void fetchAlbums() async {
    try {
      emit(AlbumLoading());
      final albums = await apiService.fetchAlbums();
      final photos = await apiService.fetchPhotos();
      emit(AlbumLoaded(albums, photos));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }
}