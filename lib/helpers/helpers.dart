import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kosher_dart/kosher_dart.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/helpers/home_screen_details_repository.dart';
import 'package:pocket_siddur/models/parasha.dart';
import 'package:pocket_siddur/models/userLocation.dart';
import 'package:pocket_siddur/size_config.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yaml/yaml.dart';

class Helper {
  Future<String> getVersionFromPubspec(BuildContext context) async {
    final String pubspecYaml = await rootBundle.loadString(
      'pubspec.yaml',
    );
    final Map<dynamic, dynamic> yamlMap = loadYaml(
      pubspecYaml,
    );
    return yamlMap['version'];
  }

  Widget SharePrayerTime(
    BuildContext context,
    String message, {
    Color color = primaryColor,
    String subject = "Parashah Summary",
  }) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Share.share(
            message,
            subject: subject,
            sharePositionOrigin: Rect.fromCenter(
              center: Offset(0, 0),
              width: 50,
              height: 50,
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Share ',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            SvgPicture.asset(
              "assets/icons/share.svg",
              color: color,
              height: getProportionateScreenHeight(25),
            ),
          ],
        ),
      ),
    );
  }

  void updateHomeScreenDetails(ProviderService provider) {
    GeoLocation geoLocation = GeoLocation.setLocation(
      provider.getUserLocation.locationName!,
      provider.getUserLocation.latitude!,
      provider.getUserLocation.longitude!,
      DateTime.now().toUtc(),
    );
    ComplexZmanimCalendar.intGeoLocation(geoLocation);
    var gregorianDate = DateFormat.yMMMd().format(DateTime.now());
    JewishDate jewishDate = JewishDate();
    JewishCalendar jewishCalendar = JewishCalendar();
    ComplexZmanimCalendar complexZmanimCalendar = ComplexZmanimCalendar()
      ..setGeoLocation(geoLocation);
    HebrewDateFormatter translatedDateFormatter = HebrewDateFormatter()
      ..hebrewFormat = false;

    var addedDay = provider.addedDays;
    if (addedDay > 0) {
      jewishCalendar.setDate(DateTime.now().add(Duration(days: addedDay)));
      jewishDate.setDate(DateTime.now().add(Duration(days: addedDay)));
    }
    var todaysHebrewDate = translatedDateFormatter.format(jewishDate);
    if (addedDay > 0) {
      gregorianDate = DateFormat.yMMMd().format(
        DateTime.now().add(
          Duration(
            days: addedDay,
          ),
        ),
      );
      provider.updateTodaysDate("Date: $gregorianDate | $todaysHebrewDate");
    } else {
      provider.updateTodaysDate("Today: $gregorianDate | $todaysHebrewDate");
    }
    var parasha = translatedDateFormatter.formatWeeklyParsha(jewishCalendar);
    var events = translatedDateFormatter.getEventsList(
      jewishCalendar,
      complexZmanimCalendar,
    );

    var dayOfWeek = translatedDateFormatter.formatDayOfWeek(jewishCalendar);
    if (events.contains(parasha)) {
      events.add("It's Yom Shabbath");
    }
    if (dayOfWeek == "Fri") {
      events.add(
        "It's Erev Shabbath ${parasha}, prepare to welcome the bride.",
      );
    }
    if (events.isEmpty) {
      events.add(
          "No special event today – take a moment for personal reflection.");
    }
    provider.updateEventList(events);

    var startTime = complexZmanimCalendar.getShabbosStartTime();
    var endTime = complexZmanimCalendar.getShabbosExitTime();
    var lightingTime =
        '${DateFormat.E().addPattern('jm').format(startTime)} - ${DateFormat.E().addPattern('jm').format(endTime)}';

    var weeklyParasha = parashot.where((x) => x.name.contains(parasha)).first;
    provider.updateLightingTime(lightingTime);
    provider.updateParasha(weeklyParasha);

    var storedVerseOfTheDay = provider.getVerseOfTheDay;
    if (storedVerseOfTheDay.message!.isEmpty) {
      //Get and update verse of the day
      List<String> _verses = Helper().bibleVerses;
      Random random = Random();
      var today = DateTime.now();
      String contentOfVerse = _verses[random.nextInt(
        _verses.length,
      )];
      List<String> parts = contentOfVerse.split('(');
      String reference = parts.length > 1 ? parts[1].replaceAll(')', '') : '';
      var verseModel = VerseOfTheDay(
        message: parts[0],
        verse: reference,
        date: today,
      );
      provider.updateDailyVerse(verseModel);
    }
  }

  List<String> preparationDayNotificationTextOptions = [
    "TYIF!\n\n It's Friday morning, a day of preparation. Get ready for a peaceful and blessed Shabbath!\n\n Happy Preparation Day From Parashah Pal",
    "TYIF!\n\n Friday morning is here, time to prepare for a joyous and restful Shabbath.\n\n Happy Preparation Day From Parashah Pal",
    "TYIF!\n\n Embrace the morning of preparation for Shabbath. Make it a day of serenity and readiness.\n\n Happy Preparation Day From Parashah Pal",
    "TYIF!\n\n Friday has arrived. Use this morning to prepare for a meaningful and beautiful Shabbath.\n\n Happy Preparation Day From Parashah Pal",
  ];
  List<String> shabbathErevNotificationTextOptions = [
    "Shabbath Erev is approaching. Prepare for a peaceful and joyful Shabbath evening!\n\n Shabbath Shalom From Parashah Pal",
    "It's almost Shabbath Erev. Take a moment to relax and welcome the sacred Shabbath.\n\n Shabbath Shalom From Parashah Pal",
    "Get ready for Shabbath Erev. Embrace the serenity of the upcoming Shabbath evening!\n\n Shabbath Shalom From Parashah Pal",
    "The warmth of Shabbath Erev is upon us. Prepare for a blessed and restful Shabbath.\n\n Shabbath Shalom From Parashah Pal",
  ];
  List<String> dailyNotificationTextOptions = [
    "Start your week with inspiration! Explore the wisdom of the torah and find meaning in your prayers. Have a blessed day!",
    "Good morning! Dive into the teachings of the torah for today and enhance your prayer experience and relationship. Wishing you a thoughtful day!",
    "Take a moment to reflect on this weeks torah portion and connect with your prayers. May your day be filled with peace and understanding.",
    "Shalom! Begin your day by preparing for upcoming Shabbath. Delve into the Torah portion and embrace the beauty of your prayers. Enjoy a purposeful day",
    "Almost there! Start preparing for Shabbath by immersing yourself in the Torah portion and savoring the beauty of your prayers. Have a meaningful day!",
  ];

  List<String> shabbathDayNotificationTextOptions = [
    "Shabbath Shalom! Bask in the sacred atmosphere of Shabbath. Delve into the Torah portion and let your prayers bring peace and joy to your heart.\n Have a blessed and restful Shabbath!",
    "Wishing you a serene Shabbath filled with love, warmth, and spiritual connection. Reflect on the Torah portion and savor the beauty of your prayers.\n Shabbath Shalom!",
    "As the sun sets on the week, embrace the tranquility of Shabbath. Connect with the teachings of the Torah portion and let your prayers uplift your soul.\n Shabbath Shalom!",
    "Shabbath Shalom! May this day bring you rest, reflection, and spiritual rejuvenation. Dive into the Torah portion and find inspiration in your prayers.\n Enjoy a peaceful Shabbath!",
  ];

  List<String> sundayMorningNotificationTextOptions = [
    "Shavua Tov!\n\n Start your week with a grateful heart. Explore the Torah portion and let your prayers guide you on a path of wisdom and peace. Wishing you a wonderful week!",
    "Shavua Tov!\n\n Begin your week with positivity. Connect with the teachings of the Torah portion and let your prayers set the tone for a purposeful week.",
    "Shavua Tov!\n\n Embrace the new week with hope and inspiration. Reflect on the Torah portion and let your prayers be a source of strength and guidance. Have a blessed day!",
    "Shavua Tov!\n\n Wishing you a bright and joyful week! Delve into the wisdom of the Torah portion and let your prayers illuminate your path as you start the week on a positive note.",
  ];
  final List<String> bibleVerses = [
    "For I know what plans I have in mind for you,' says Yahweh, 'plans for well-being, not for bad things; so that you can have hope and a future. (Yirmeyahu 29:11)",
    "Yahshua said, 'Let the little children come to me, and don't hinder them, for the Kingdom of Heaven belongs to such as these.' (Mattityahu 19:14)",
    "I have set Yahweh before me always; because he is at my right hand, I will not be shaken. (Tehillim 16:8)",
    "Trust in Yahweh with all your heart; do not rely on your own understanding. (Mishlei 3:5)",
    "The grass withers, the flower fades, but the word of our Yahweh stands forever. (Yesha\'yahu 40:8)",
    "Yahweh is my shepherd; I shall not want. (Tehillim 23:1)",
    "Blessed is the one who reads aloud the words of this prophecy, and blessed are those who hear, and who keep what is written in it, for the time is near. (Hazon 1:3)",
    "Yahweh bless you and keep you; Yahweh make his face to shine upon you and be gracious to you; Yahweh lift up his countenance upon you and give you peace. (B\'midbar 6:24-26)",
    "The name of Yahweh is a strong tower; a righteous person runs to it and is raised high [above danger]. (Mishlei 18:10)",
    "But the fruit of the Spirit is love, joy, peace, patience, kindness, goodness, faithfulness, gentleness, self-control; against such things there is no law. (Kehilah In Galatians 5:22-23)",
    "I can do all things through him who strengthens me. (Kehilah In Philippians 4:13)",
    "And we know that in all things Yahweh works for the good of those who love him, who have been called according to his purpose. (Kehilah In Romans 8:28)",
    "Yahweh is near to the brokenhearted and saves the crushed in spirit. (Tehillim 34:18)",
    "Your word is a lamp to my feet and a light to my path. (Tehillim 119:105)",
    "Rejoice in hope, be patient in tribulation, be constant in prayer. (Romans 12:12)",
    "But the Lord is faithful. He will establish you and guard you against the evil one. (2 Thessalonians 3:3)",
    "Do not be anxious about anything, but in everything by prayer and supplication with thanksgiving let your requests be made known to Yahweh. (Kehilah In Philippians 4:6)",
    "I will instruct you and teach you in the way you should go; I will counsel you with my eye upon you. (Tehillim 32:8)",
    "The fear of Yahweh is the beginning of knowledge; fools despise wisdom and instruction. (Mishlei 1:7)",
    "But you, O Yahweh, are a shield about me, my glory, and the lifter of my head. (Tehillim 3:3)",
    "And we have seen and testify that the Father has sent his Son to be the Savior of the world. (1 Yochanan 4:14)",
    "A joyful heart is good medicine, but a crushed spirit dries up the bones. (Mishlei 17:22)",
    "Therefore, since we are surrounded by so great a cloud of witnesses, let us also lay aside every weight, and sin which clings so closely, and let us run with endurance the race that is set before us. (Ibrim 12:1)",
    "You keep him in perfect peace whose mind is stayed on you, because he trusts in you. (Yesha\'yahu 26:3)",
    "And without faith it is impossible to please him, for whoever would draw near to Yahweh must believe that he exists and that he rewards those who seek him. (Ibrim 11:6)",
    "The heart of man plans his way, but Yahweh establishes his steps. (Mishlei 16:9)",
    "You make known to me the path of life; in your presence there is fullness of joy; at your right hand are pleasures forevermore. (Tehillim 16:11)",
    "Yahweh is my light and my salvation; whom shall I fear? Yahweh is the stronghold of my life; of whom shall I be afraid? (Tehillim 27:1)",
    "But seek first the kingdom of Yahweh and his righteousness, and all these things will be added to you. (Matthew 6:33)",
    "I have fought the good fight, I have finished the race, I have kept the faith. (2 Timothy 4:7)",
    "He heals the brokenhearted and binds up their wounds. (Tehillim 147:3)",
    "And let us not grow weary of doing good, for in due season we will reap, if we do not give up. (Galatians 6:9)",
    "I will give thanks to you, Yahweh, with all my heart; I will tell of all your wonderful deeds. (Tehillim 9:1)",
    "But you are a chosen people, a royal priesthood, a holy nation, Yahweh’s special possession, that you may declare the praises of him who called you out of darkness into his wonderful light. (1 Kefa 2:9)",
    "The steadfast love of Yahweh never ceases; his mercies never come to an end; they are new every morning; great is your faithfulness. (Lamentations 3:22-23)",
    "And let the peace of Yahshua rule in your hearts, to which indeed you were called in one body. And be thankful. (Colossians 3:15)",
    "I will both lie down and sleep in peace, for you alone, O Yahweh, make me dwell in safety. (Tehillim 4:8)",
    "Now faith is the assurance of things hoped for, the conviction of things not seen. (Ibrim 11:1)",
    "The Lord is good, a stronghold in the day of trouble; he knows those who take refuge in him. (Nahum 1:7)",
    "And we know that for those who love Yahweh all things work together for good, for those who are called according to his purpose. (Romans 8:28)",
    "Have I not commanded you? Be strong and courageous. Do not be frightened, and do not be dismayed, for Yahweh your Elohim is with you wherever you go. (Y\'hoshua 1:9)",
    "But let all who take refuge in you rejoice; let them ever sing for joy, and spread your protection over them, that those who love your name may exult in you. (Tehillim 5:11)",
    "But the fruit of the Spirit is love, joy, peace, patience, kindness, goodness, faithfulness, gentleness, self-control; against such things there is no law. (Galatians 5:22-23)",
    "Even though I walk through the valley of the shadow of death, I will fear no evil, for you are with me; your rod and your staff, they comfort me. (Tehillim 23:4)",
    "Let not your hearts be troubled. Believe in Yahweh; believe also in me. (Yochanan 14:1)",
    "May Yahweh of hope fill you with all joy and peace in believing, so that by the power of the Ruach Ka-Kodesh you may abound in hope. (Romans 15:13)",
    "He will wipe away every tear from their eyes, and death shall be no more, neither shall there be mourning, nor crying, nor pain anymore, for the former things have passed away. (Revelation 21:4)",
  ];
}
