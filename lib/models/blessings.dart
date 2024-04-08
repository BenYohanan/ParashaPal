class Blessing {
  final int id;
  final String name;
  final String audioFilePath;
  final String description;
  final String shortDescriptionAboutPrayer;

  Blessing({
    required this.id,
    required this.name,
    required this.audioFilePath,
    required this.description,
    required this.shortDescriptionAboutPrayer,
  });
}

List<Blessing> blessings = [
  Blessing(
    id: 1,
    name: "Modeh Ani (Thankful)",
    audioFilePath: "assets/audios/ModehAni.mp3",
    description:
    """
      Hebrew:
      Modeh ani lifanecha melech chai vekayam 
      shehechezarta bi nishmati b'chemlah 
      Raba emunatecha

      English:
      I offer thanks to You, living and 
      eternal King, for You have mercifully 
      restored my soul within me; 
      Your faithfulness is great.
    """,
    shortDescriptionAboutPrayer: "Expressing gratitude for waking up.",
  ),
  Blessing(
    id: 2,
    name: "Shema Yisrael (Hear, O Israel)",
    audioFilePath: "assets/audios/ShemaYisrael.mp3",
    description: """
      Hebrew:
      Shema Yisrael Yahweh Eloheinu Yahweh Echad
      Baruch shem kevod malchuto l'olam va'ed

      English:
      Hear, O Israel: Yahweh is our mighty one, 
      Yahweh is One. Blessed be the Name of His
      glorious kingdom forever and ever.
    """,
    shortDescriptionAboutPrayer: "Declaration of faith and unity.",
  ),
  Blessing(
    id: 3,
    name: "Asher Yatzar (Who has Created)",
    audioFilePath: "assets/audios/AsherYatzar.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam,
      asher yatzar et ha'adam b'chochmah,
      u'vara vo nekavim, nekavim, chalulim, 
      chalulim. Galuy v'yadua lifnei chisei 
      chvodecha she'im yipatei'ach echad meihem,
      o yisata'em echad meihem, oy khalul chalul
      aycher meihem, mei'yad nifkadai 
      ve'nifkadai keshem shehu nifkadai 
      ve'nifkadai. Ve'chalaloy yehi ratzon
      milfanay she'tehei rachamim aleihem.

      English:
      Blessed are You, Yahweh our mighty one, 
      King of the universe, Who formed man 
      with wisdom, and created within him 
      many openings and many cavities. It 
      is obvious and known before Your 
      Throne of Glory that if one of them
      were to be ruptured, or if one of them 
      were to be blocked, it would be
      impossible to survive and to stand 
      before You, due to the severity of 
      the rupture or blockage. Blessed are You, 
      Yahweh, Who heals all flesh and acts 
      wondrously.
    """,
    shortDescriptionAboutPrayer: "Gratitude for bodily functions.",
  ),
  Blessing(
    id: 4,
    name: "Birkat Hamazon (Grace After Meals)",
    audioFilePath: "assets/audios/BirkatHamazon.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam,
      hazan et ha'olam kulo b'tuvo b'chein b'chesed 
      uv'rachamim, hu noten lechem l'chol basar,
      ki l'olam chasdo. Uv'tuvo hagadol, 
      tamid lo chasar lanu, v'al yechsar lanu 
      mazon l'olam va'ed. Ba'avur shmo hagadol,
      ki hu Eil zan um'farnes lakol umetiv 
      lakol u'meichin mazon l'chol 
      b'riyotav asher bara.

      English:
      Blessed are You, Yahweh our mighty one, 
      King of the universe, who nourishes the 
      entire world with goodness, with grace, 
      with kindness, and with mercy. He gives 
      food to all flesh, for His loving-kindness
      is everlasting. And through His great 
      goodness, we have never lacked, and may
      we never lack food forever and ever.
      For the sake of His great Name, for
      He is a nourishing and sustaining 
      Elohim to all, doing good to all, and
      providing food for all His creatures 
      whom He created.
    """,
    shortDescriptionAboutPrayer: "Thanksgiving after eating.",
  ),
  Blessing(
    id: 5,
    name: "Hamotzi (Who Brings Forth Bread)",
    audioFilePath: "assets/audios/Hamotzi.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam,
      hamotzi lechem min ha'aretz.

      English:
      Blessed are You, Yahweh our Mighty one, 
      King of the universe, who brings 
      forth bread from the earth.
    """,
    shortDescriptionAboutPrayer: "Blessing over bread.",
  ),
  Blessing(
    id: 6,
    name: "Al Netilat Yadayim (Washing of Hands)",
    audioFilePath: "assets/audios/AlNetilatYadayim.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam,
      asher kid'shanu b'mitzvotav
      v'tzivanu al netilat yadayim.

      English:
      Blessed are You, Yahweh our Mighty one, 
      King of the universe, who has sanctified 
      us with His commandments and commanded 
      us concerning the washing of hands.
    """,
    shortDescriptionAboutPrayer: "Blessing for washing hands.",
  ),
  Blessing(
    id: 7,
    name: "HaGefen (Who Creates the Fruit of the Vine)",
    audioFilePath: "assets/audios/HaGefen.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam,
      borei pri hagafen.

      English:
      Blessed are You, Yahweh our Mighty one, 
      King of the universe,
      who creates the fruit of the vine.
    """,
    shortDescriptionAboutPrayer: "Blessing over wine.",
  ),
  Blessing(
    id: 8,
    name: "HaEitz (Who Creates the Fruit of the Tree)",
    audioFilePath: "assets/audios/HaEitz.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam,
      borei pri ha'etz.

      English:
      Blessed are You, Yahweh our Mighty one, 
      King of the universe,
      who creates the fruit of the tree.
    """,
    shortDescriptionAboutPrayer: "Blessing over fruit of the tree.",
  ),
  Blessing(
    id: 9,
    name: "Shehecheyanu (Who Has Kept Us Alive)",
    audioFilePath: "assets/audios/Shehecheyanu.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam,
      shehecheyanu, v'kiy'manu, v'higi'anu 
      laz'man hazeh.

      English:
      Blessed are You, Yahweh our Mighty one, 
      King of the universe, who has kept 
      us alive, sustained us, and enabled 
      us to reach this season.
    """,
    shortDescriptionAboutPrayer: "Blessing for new experiences.",
  ),
  Blessing(
    id: 10,
    name: "Baruch Atah Yahweh (Blessed Are You, O Yahweh)",
    audioFilePath: "assets/audios/BaruchAtahAdonai.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam.

      English:
      Blessed are You, Yahweh our Mighty one, 
      King of the universe.
    """,
    shortDescriptionAboutPrayer: "General blessing.",
  ),
  Blessing(
    id: 11,
    name: "Kiddush (Sanctification)",
    audioFilePath: "assets/audios/Kiddush.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam,
      borei pri hagafen.

      English:
      Blessed are You, Yahweh our Mighty one, 
      King of the universe,
      who creates the fruit of the vine.
    """,
    shortDescriptionAboutPrayer: "Blessing over wine on Shabbat.",
  ),
  Blessing(
    id: 12,
    name: "Motzi (Bringer Forth)",
    audioFilePath: "assets/audios/Motzi.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam,
      hamotzi lechem min ha'aretz.

      English:
      Blessed are You, Yahweh our Mighty one, 
      King of the universe,
      who brings forth bread from the earth.
    """,
    shortDescriptionAboutPrayer: "Blessing over bread before a meal.",
  ),
  Blessing(
    id: 13,
    name: "Havdalah (Separation)",
    audioFilePath: "assets/audios/Havdalah.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam,
      borei m'orei ha'eish.

      English:
      Blessed are You, Yahweh our Mighty one, 
      King of the universe,
      who creates the lights of fire.
    """,
    shortDescriptionAboutPrayer: "Blessing to end Shabbat.",
  ),
  Blessing(
    id: 14,
    name: "Hagomel (Who Bestows Goodness)",
    audioFilePath: "assets/audios/Hagomel.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam,
      hagomel l'chayavim tovot sheg'malani kol tov.

      English:
      Blessed are You, Yahweh our Mighty one, 
      King of the universe, who bestows 
      goodness upon the undeserving, 
      who has bestowed every goodness upon me.
    """,
    shortDescriptionAboutPrayer: "Blessing for being saved from danger.",
  ),
  Blessing(
    id: 15,
    name: "Hamapil (The One Who Makes Me Sleep)",
    audioFilePath: "assets/audios/Hamapil.mp3",
    description: """
      Hebrew:
      Baruch atah Yahweh, Eloheinu Melech haolam,
      hamapil chevlei sheinah al einei.

      English:
      Blessed are You, Yahweh our Mighty one, 
      King of the universe, who makes me lie 
      down in peace and let me sleep.
    """,
    shortDescriptionAboutPrayer: "Blessing before going to sleep.",
  ),
  Blessing(
    id: 16,
    name: "Tefilat Haderech (Traveler's Prayer)",
    audioFilePath: "assets/audios/TefilatHaderech.mp3",
    description: """
      Hebrew:
      Yehi ratzon milfanekha Yahweh Eloheinu veilohei 
      avoteinu she'tolichenu l'shalom
      v'tatz'idenu l'shalom v'tadrikhenu l'shalom,
      v'tagi'enu limchoz cheftzeinu l'chayim 
      ul'simchah ul'shalom, v'tatz'ilenu mikaf 
      kol oyev v'orev v'listim v'chayot 
      ra'ot ba'derech, u'mikol minei pur'aniyot 
      ha'mitrag'shot lavo la'olam. Ve'tishlach 
      b'rakhah b'khol ma'asei yadeinu, 
      v'tit'lokhenu l'shalom, v'tatz'idenu 
      l'shalom, v'tagi'enu l'shalom, v'tagi'enu 
      limchoz chayim ul'simchah ul'shalom,
      v'tatz'ilenu mikol oyev v'orev, 
      v'listim v'chayot ra'ot ba'derech, u'mikol 
      minei pur'aniyot ha'mitrag'shot lavo la'olam.
      Yehi ratzon milfanekha, Yahweh Eloheinu 
      veilohei avoteinu, she'tishmor etenu 
      ba'derech ha'zeh l'shalom, v'tatz'ilenu 
      mi'kol tzarah, v'tatz'idenu mi'kol 
      yisurim, v'tagi'enu l'shalom, u'l'simchah, 
      v'tatzilenu mikol oyev v'orev, v'listim 
      v'chayot ra'ot ba'derech, u'mikol minei 
      pur'aniyot ha'mitrag'shot lavo la'olam.
      V'tishlach b'rakhah b'khol ma'asei yadeinu, 
      v'tit'lokhenu l'shalom, v'tatz'idenu 
      l'shalom, v'tagi'enu l'shalom, v'tagi'enu 
      limchoz chayim ul'simchah ul'shalom, 
      v'tatz'ilenu mikol oyev v'orev, v'listim 
      v'chayot ra'ot ba'derech, u'mikol 
      minei pur'aniyot ha'mitrag'shot 
      lavo la'olam. V'tishlach b'rakhah 
      b'khol ma'asei yadeinu, v'tit'lokhenu 
      l'shalom, v'tatz'idenu l'shalom, 
      v'tagi'enu l'shalom, v'tagi'enu 
      limchoz chayim ul'simchah ul'shalom, 
      v'tatz'ilenu mikol oyev v'orev, 
      v'listim v'chayot ra'ot ba'derech, 
      u'mikol minei pur'aniyot 
      ha'mitrag'shot lavo la'olam.

      English
      May it be Your will, Yahweh our Mighty 
      one and the mighty of our ancestors,
      that You lead us toward peace, 
      guide our footsteps toward peace,
      and make us reach our desired destination 
      for life, gladness, and peace.
      May You rescue us from the hand 
      of every foe, ambush along the way,
      and from all manner of punishments 
      that assemble to come to earth.
      May You send blessing in our handiwork, 
      and grant us grace, kindness, and mercy
      in Your eyes and in the eyes of 
      all who see us. May You hear the 
      sound of our humble request because 
      You are Yahweh who hears prayers and 
      supplications. Blessed are You, 
      Yahweh, who hears prayer.
    """,
    shortDescriptionAboutPrayer: "Prayer for a safe journey.",
  ),
];


