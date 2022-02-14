class Chat {
  String? name;
  String? message;
  String? time;
  String? avatarUrl;

  Chat({this.name, this.message, this.avatarUrl, this.time});
}

List<Chat> fakeData = [
    Chat(
        name: "Mert",
        message: "Merhaba",
        time: "13:30",
        avatarUrl:
            "https://www.cumhuriyet.com.tr/Archive/2021/10/2/1873546/kapak_094953.jpg"),
    Chat(
        name: "Kartal",
        message: "Bilemiyorum altan",
        time: "13:35",
        avatarUrl:
            "https://korebu.com/wp-content/uploads/2021/09/squid-game-jung-ho-yeon-850x566.jpg"),
    Chat(
        name: "Burak",
        message: "Memiktaş şampiyon?",
        time: "14:30",
        avatarUrl:
            "https://www.sanliurfagazetesi.com/images/haberler/2018/06/sivas-ta-kacakcilardan-kurtarilan-yavru-kartal-sanliurfa-da-koruma-altina-alindi.jpg"),
    Chat(
        name: "Kutlu",
        message: "Merhabalar aq",
        time: "15:38",
        avatarUrl:
            "https://scontent.fsaw1-11.fna.fbcdn.net/v/t1.18169-9/cp0/e15/q65/s320x320/10632647_1682886651961901_8353947389615478336_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=dd9801&_nc_ohc=NLjX60Gl0hUAX_-cVii&_nc_ht=scontent.fsaw1-11.fna&oh=6dabf5deb74c08e03ef6305ff4487ecf&oe=617EAAD7")
  ];