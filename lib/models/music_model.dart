class MusicModel {
  final int id;
  final String title;
  final String album;
  final String link;
  final String profileImage;
  bool fav;

  MusicModel({
    required this.id,
    required this.title,
    required this.album,
    required this.link,
    required this.profileImage,
    this.fav = false,
  });

  static List<MusicModel> list = [
    MusicModel(
        id: 1,
        fav: false,
        title: "Killer Queen",
        album: "The Queen",
        link:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/sounds/Queen-Killer-Queen.mp3',
        profileImage:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/images/queen.jpg'),
    MusicModel(
        id: 2,
        fav: false,
        title: "Hammer to Fall",
        album: "The Queen",
        link:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/sounds/Queen-Hammer-To-Fall.mp3',
        profileImage:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/images/queen.jpg'),
    MusicModel(
        id: 3,
        fav: false,
        title: "Numb",
        album: "Linkin Park",
        link:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/sounds/Linkin_Park_Numb.mp3',
        profileImage:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/images/linkin_park_numb_image.jpg'),
    MusicModel(
        id: 4,
        fav: false,
        title: "We Are The Champions",
        album: "The Queen",
        link:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/sounds/Queen-We-Are-The-Champions.mp3',
        profileImage:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/images/queen.jpg'),
    MusicModel(
        id: 5,
        fav: false,
        title: "Don't Go Yet",
        album: "Camilla Cabello",
        link:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/sounds/Camila+Cabello+-+Don+t+Go+Yet+(Official+Video).mp3',
        profileImage:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/images/images.jfif'),
    MusicModel(
        id: 6,
        fav: false,
        title: "Here",
        album: "Alessia Cara - [Lucian Remix]",
        link:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/sounds/Alessia_Cara_Here.mp3',
        profileImage:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/images/alessiacara.jpg'),
    MusicModel(
        id: 7,
        fav: false,
        title: "This is How I Learn To Say No",
        album: "Emeline",
        link:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/sounds/EMELINE+-+this+is+how+i+learn+to+say+no.mp3',
        profileImage:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/images/this+is+how+EMELINE.jpg'),
    MusicModel(
        id: 8,
        fav: false,
        title: "Beggin",
        album: "Maneskin",
        link:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/sounds/M%C3%A5neskin+-+Beggin+.mp3',
        profileImage:
            'https://assets-sounds.s3.ap-south-1.amazonaws.com/images/maneskin.jpg'),
  ];
}
