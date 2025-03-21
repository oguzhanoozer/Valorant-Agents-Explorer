import '../services/api/api_service.dart';

sealed class ImageStatus {
  const ImageStatus();
}

final class ImageReady extends ImageStatus {
  const ImageReady();
}

final class ImageNotDownloaded extends ImageStatus {
  const ImageNotDownloaded();
}

final class ImageDownloading extends ImageStatus {
  final CancelToken cancelToken;

  ImageDownloading() : cancelToken = CancelToken();

  void cancel() {
    if (!cancelToken.isCancelled) {
      cancelToken.cancel();
    }
  }
}
