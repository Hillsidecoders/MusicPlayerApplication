import 'package:flutter/material.dart';
import 'package:melophile/models/music_model.dart';
import 'package:melophile/pages/detail_page.dart';
import 'package:melophile/uitools/const.dart';
import 'package:melophile/widgets/custom_button_widget.dart';

class MusicList extends StatefulWidget {
  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  late List<MusicModel> _list;
  late int _playId;
  bool favClick = false;

  @override
  void initState() {
    _playId = 1;
    _list = MusicModel.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "M E L O P H I L E",
          style: TextStyle(
            color: AppColors.styleColor,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomButtonWidget(
                      child: Icon(
                        Icons.favorite,
                        color: _list[_playId - 1].fav
                            ? Colors.red.shade200
                            : AppColors.styleColor,
                      ),
                      size: 50,
                      onTap: () {
                        setState(() {
                          _list[_playId - 1].fav = true;
                        });
                      },
                    ),
                    CustomButtonWidget(
                      child: Icon(
                        Icons.disc_full,
                        color: AppColors.styleColor.withAlpha(0),
                      ),
                      image: 'default',
                      size: 150,
                      borderWidth: 5,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailPage(
                              songName: _list[_playId - 1].title,
                              albumName: _list[_playId - 1].album,
                              profileImg: _list[_playId - 1].profileImage,
                              audioPath: _list[_playId - 1].link,
                            ),
                          ),
                        );
                      },
                    ),
                    CustomButtonWidget(
                      child: Icon(
                        Icons.menu_rounded,
                        color: AppColors.styleColor,
                      ),
                      size: 50,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Text("PLAYLIST"),
                height: 25,
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _list.length,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _playId = _list[index].id;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailPage(
                              songName: _list[index].title,
                              albumName: _list[index].album,
                              profileImg: _list[index].profileImage,
                              audioPath: _list[index].link,
                            ),
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          color: _list[index].id == _playId
                              ? AppColors.activeColor
                              : AppColors.mainColor,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      _list[index].title,
                                      style: TextStyle(
                                        color: AppColors.styleColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  _list[index].album,
                                  style: TextStyle(
                                    color: AppColors.styleColor.withAlpha(90),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            CustomButtonWidget(
                              child: Icon(
                                _list[index].id == _playId
                                    ? Icons.music_note
                                    : Icons.play_arrow,
                                color: _list[index].id == _playId
                                    ? Colors.white
                                    : AppColors.styleColor,
                              ),
                              size: 50,
                              isActive: _list[index].id == _playId,
                              onTap: () {
                                setState(() {
                                  _playId = _list[index].id;
                                });
                              },
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.mainColor.withAlpha(0),
                    AppColors.mainColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
