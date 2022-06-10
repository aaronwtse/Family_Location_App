import "dart:math";
// does random quotes
String randomUsername() {
  var list = ['Candy Lane','Sugar Field','Donut Kingdom'];
  final _random = new Random();
  return list[_random.nextInt(list.length)];
}

String randomRepPic() {
  var list = ['https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/cat%20pic.jpg?alt=media&token=17f77da7-4f60-4eb5-abd0-bccf1fcf04e5','https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/funny-dog-captions-1563456605.jpg?alt=media&token=964e93c5-e911-49ec-9e91-35c11080f1be','https://firebasestorage.googleapis.com/v0/b/inspiring-quotes-9e078.appspot.com/o/night%20sky.jpg?alt=media&token=5d7810e9-48b3-4cf0-99a4-01484f7ff984'];
  final _random = new Random();
  return  list[_random.nextInt(list.length)];
}

String randomDescription() {
  var list = ['Love trumps Hate','I am free','LaLaLa'];
  final _random = new Random();
  return list[_random.nextInt(list.length)];
}

