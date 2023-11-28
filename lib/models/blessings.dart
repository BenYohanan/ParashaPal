class Blessing {
  final int id;
  final String name;
  final String audioFilePath;
  final String description;

  Blessing({
    required this.id,
    required this.name,
    required this.audioFilePath,
    required this.description,
  });
}

List<Blessing> blessing = [
  Blessing(
    id: 1,
    name: "Modeh Ani",
    audioFilePath: "assets/audios/03EitzChayim.mp3",
    description: """
        Hebrew:
        Modeh Ani L’fanecha
        Melech Chai V’kayam
        Shehechezarta Bi Nishmati B'chemla
        Raba Emunatecha

        English:
        I offer thanks to You,
        living and eternal King,
        for You have mercifully restored my soul within me;
        Your faithfulness is great.
    """,
  ),
];
