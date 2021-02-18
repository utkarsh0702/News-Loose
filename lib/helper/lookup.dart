String imageLookUp(int num){
  String image;
  var details = {
    1 : 'assets/avatar/avatar1.png',
    2 : 'assets/avatar/avatar2.png',
    3 : 'assets/avatar/avatar3.png',
    4 : 'assets/avatar/avatar4.png',
    5 : 'assets/avatar/avatar5.png',
    6 : 'assets/avatar/avatar6.png',
    7 : 'assets/avatar/avatar7.png',
    8 : 'assets/avatar/avatar8.png',
    9 : 'assets/avatar/avatar9.png',
    };
  image = details[num];
  return image;
}