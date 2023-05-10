import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoListPage extends StatefulWidget {
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  final List<Map<String, String>> videoList = [
    {
      'facultyName': 'Mrs. G. Poornima',
      'department': 'Commerce',
      'topic': 'Principles of Management',
      'videoId': '2uTUaxLyRD4',
      'thumbnailUrl': 'https://img.youtube.com/vi/2uTUaxLyRD4/mqdefault.jpg'
    },
    {
      'facultyName': 'Mr. G.R. Dineshkumar',
      'department': 'Commerce PA',
      'topic': 'Cost Accounting',
      'videoId': 'pcTQID3FRt8',
      'thumbnailUrl': 'https://img.youtube.com/vi/mgTmaPNi2ag/mqdefault.jpg'
    },
    {
      'facultyName': 'Ms. Athulya Baby',
      'department': 'Commerce',
      'topic': 'Management Accounting',
      'videoId': 'ZprPgmMoB2M',
      'thumbnailUrl': 'https://img.youtube.com/vi/sCwOuH0vs7Y/mqdefault.jpg'
    },
    {
      'facultyName': 'Dr. M. Kavitha',
      'department': 'Commerce PA',
      'topic': '	Advanced Accounting',
      'videoId': 'i4FxbIEHOoI',
      'thumbnailUrl': 'https://img.youtube.com/vi/2uTUaxLyRD4/mqdefault.jpg'
    },
    {
      'facultyName': 'Dr. C. Chandraleka',
      'department': 'BCA & IT',
      'topic': 'Computer Networks',
      'videoId': 'mgTmaPNi2ag',
      'thumbnailUrl': 'https://img.youtube.com/vi/2uTUaxLyRD4/mqdefault.jpg'
    },
    {
      'facultyName': 'Mrs. J.P. Nandhinishree',
      'department': '	Computer Science',
      'topic': 'C++ Programming',
      'videoId': 'f-3I72vsmjY',
      'thumbnailUrl': 'https://img.youtube.com/vi/2uTUaxLyRD4/mqdefault.jpg'
    },
    {
      'facultyName': '	Mr. M. Rajeshkumar',
      'department': 'Computer Applications ',
      'topic': 'Graphics & Multimedia',
      'videoId': 'TTjdAcgiiHQ',
      'thumbnailUrl': 'https://img.youtube.com/vi/mgTmaPNi2ag/mqdefault.jpg'
    },
    {
      'facultyName': 'Ms. M. Jayakeerthi',
      'department': 'Computer Science',
      'topic': 'Advanced JAVA',
      'videoId': 'mcNNsUi58Hs',
      'thumbnailUrl': 'https://img.youtube.com/vi/sCwOuH0vs7Y/mqdefault.jpg'
    },
    {
      'facultyName': 'Ms. I. Jubitha',
      'department': 'Compuper Science',
      'topic': 'Web Technology',
      'videoId': 'L3ty9Be9_Q4',
      'thumbnailUrl': 'https://img.youtube.com/vi/2uTUaxLyRD4/mqdefault.jpg'
    },
    {
      'facultyName': 'Rajeshwari N',
      'department': 'Dept of Computer Applications',
      'topic': 'Cloud Computing',
      'videoId': '3aG66ILovMo',
      'thumbnailUrl': 'https://img.youtube.com/vi/2uTUaxLyRD4/mqdefault.jpg'
    },
  ];

  late YoutubePlayerController _playerController;
  Map<String, String> _selectedVideo = {};

  @override
  void initState() {
    super.initState();
    _playerController = YoutubePlayerController(
      initialVideoId: videoList[0]['videoId']!,
      flags: const YoutubePlayerFlags(
        autoPlay: false, // set autoPlay to false
        mute: false,
      ),
    );
    _selectedVideo = videoList[0];
  }

  void playVideo(String videoId, Map<String, String> video) {
    _playerController.load(videoId); // load the video
    setState(() {
      _selectedVideo = video; // update the selected video
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('video lectures'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: YoutubePlayer(
                controller: _playerController,
                showVideoProgressIndicator: true,
                aspectRatio: 16 / 9,
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedVideo['topic']!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${_selectedVideo['facultyName']} - ${_selectedVideo['department']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: videoList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    playVideo(videoList[index]['videoId']!, videoList[index]);
                  },
                  child: Container(
                    color: Color.fromARGB(255, 227, 224, 224),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          videoList[index]['topic']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${videoList[index]['facultyName']} - ${videoList[index]['department']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
