import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileStorageService {
  FileStorageService({FirebaseStorage? storage})
    : _storage = storage ?? FirebaseStorage.instance;

  final FirebaseStorage _storage;

  /// Upload a single file and return download URL
  Future<String> uploadFile({
    required String localPath,
    required String storagePath,
    SettableMetadata? metadata,
  }) async {
    final file = File(localPath);

    final task = await _storage.ref(storagePath).putFile(file, metadata);

    return task.ref.getDownloadURL();
  }

  /// Upload a single file and return storage path
  Future<String> uploadFileAndReturnPath({
    required String localPath,
    required String storagePath,
    SettableMetadata? metadata,
  }) async {
    final file = File(localPath);

    await _storage.ref(storagePath).putFile(file, metadata);

    return storagePath;
  }

  /// Upload multiple files and return download URLs
  Future<List<String>> uploadFiles({
    required List<FileUploadRequest> files,
  }) async {
    return Future.wait(
      files.map(
        (file) => uploadFile(
          localPath: file.localPath,
          storagePath: file.storagePath,
          metadata: file.metadata,
        ),
      ),
    );
  }

  /// Delete file by storage path
  Future<void> deleteFile(String storagePath) async {
    await _storage.ref(storagePath).delete();
  }

  /// Delete file by download URL
  Future<void> deleteFileFromUrl(String downloadUrl) async {
    final ref = _storage.refFromURL(downloadUrl);
    await ref.delete();
  }

  /// Delete multiple files
  Future<void> deleteFiles(List<String> storagePaths) async {
    await Future.wait(storagePaths.map(deleteFile));
  }

  /// Check if file exists
  Future<bool> fileExists(String storagePath) async {
    try {
      await _storage.ref(storagePath).getMetadata();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Get download URL
  Future<String> getDownloadUrl(String storagePath) async {
    return _storage.ref(storagePath).getDownloadURL();
  }

  /// Get metadata
  Future<FullMetadata> getMetadata(String storagePath) async {
    return _storage.ref(storagePath).getMetadata();
  }

  /// Update metadata
  Future<FullMetadata> updateMetadata({
    required String storagePath,
    required SettableMetadata metadata,
  }) async {
    return _storage.ref(storagePath).updateMetadata(metadata);
  }

  /// Get file size in bytes
  Future<int?> getFileSize(String storagePath) async {
    final metadata = await getMetadata(storagePath);
    return metadata.size;
  }

  /// List files inside folder
  Future<ListResult> listFiles({
    required String folderPath,
    int maxResults = 100,
  }) async {
    return _storage.ref(folderPath).list(ListOptions(maxResults: maxResults));
  }
}

class FileUploadRequest {
  final String localPath;
  final String storagePath;
  final SettableMetadata? metadata;

  const FileUploadRequest({
    required this.localPath,
    required this.storagePath,
    this.metadata,
  });
}
