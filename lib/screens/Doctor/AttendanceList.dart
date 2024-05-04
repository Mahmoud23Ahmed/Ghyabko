import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ghyabko/screens/auth/Login_Screen.dart';

class FirebaseStorageFileListScreen extends StatefulWidget {
  final String subName;

  const FirebaseStorageFileListScreen({Key? key, required this.subName})
      : super(key: key);

  @override
  _FirebaseStorageFileListScreenState createState() =>
      _FirebaseStorageFileListScreenState();
}

class _FirebaseStorageFileListScreenState
    extends State<FirebaseStorageFileListScreen> {
  List<firebase_storage.Reference> _fileList = [];

  @override
  void initState() {
    super.initState();
    initializeDownloader();
    _getFileList();
  }

  Future<void> initializeDownloader() async {
    await FlutterDownloader.initialize(debug: true);
  }

  Future<void> _getFileList() async {
    try {
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
      firebase_storage.ListResult result = await storage.ref().listAll();

      setState(() {
        _fileList = result.items
            .where((ref) => ref.name.contains(widget.subName))
            .toList();
      });
    } catch (e) {
      print('Error fetching file list: $e');
    }
  }

  Future<void> _downloadExcelFile(String subName) async {
    try {
      firebase_storage.Reference? excelFile;
      for (var file in _fileList) {
        if (file.name.contains(widget.subName) && file.name.endsWith('.csv')) {
          excelFile = file;
          break;
        }
      }
      if (excelFile == null) {
        print('Excel file not found for subName: $subName');
        return;
      }

      String url = await excelFile.getDownloadURL();
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: '/storage/emulated/0/Download/',
        showNotification: true,
        openFileFromNotification: true,
      );
      print('Download task id: $taskId');
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor,
        title: Text(
          "Attendance List",
          style: const TextStyle(
              fontFamily: 'LibreBaskerville',
              fontSize: 23,
              color: Colors.white),
        ),
      ),
      body: _fileList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: _fileList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 160),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _downloadExcelFile(widget.subName);
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/excel.png",
                            height: 100,
                          ),
                          Text(_fileList[index].name),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
