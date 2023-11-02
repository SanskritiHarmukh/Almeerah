import 'package:flutter/material.dart';

class ZodiacOutfit extends StatefulWidget {
  const ZodiacOutfit({Key? key}) : super(key: key);

  @override
  State<ZodiacOutfit> createState() => _ZodiacOutfitState();
}

class _ZodiacOutfitState extends State<ZodiacOutfit> {
  String selectedZodiacSign = "Aries"; // Default zodiac sign
  String selectedColor = "Red"; // Default preferred color

  final Map<String, String> zodiacData = {
    "Aries": "Wear bold and fiery colors like red and orange.",
    "Taurus": "Earth tones like green and brown will suit you well.",
    "Gemini": "Try mixing and matching different styles for a unique look.",
    "Cancer": "Soft and calming colors like blue and silver will resonate with your emotional nature. Choose outfits that make you feel cozy and secure.",
    "Leo": "Regal and vibrant colors like gold and royal purple are your go-to choices. Show your inner royalty with your outfits.",
    "Virgo": "Neat and understated colors like beige and pastels match your meticulous nature. Opt for well-organized and elegant attire.",
    "Libra": "Elegant and harmonious colors like pink and light blue reflect your balanced personality. Choose outfits that exude grace and charm.",
    "Scorpio": "Intense and mysterious colors like black and dark red suit your passionate nature. Embrace the power of your wardrobe choices.",
    "Sagittarius": "Vibrant and adventurous colors like bright blue and purple match your free-spirited personality. Explore bold and dynamic outfits.",
    "Capricorn": "Classic and practical colors like gray and dark green resonate with your disciplined nature. Opt for timeless and reliable attire.",
    "Aquarius": "Unique and futuristic colors like electric blue and silver are your style. Be original and embrace unconventional clothing.",
    "Pisces": "Dreamy and ethereal colors like seafoam green and lavender match your imaginative nature. Choose outfits that reflect your artistic side."
  };

  final Map<String, Map<String, String>> dailyHoroscope = {
    "Aries": {
      "Monday": "You're full of energy and ready to take on new challenges.",
      "Tuesday": "Your leadership qualities shine today; take the lead in projects.",
      "Wednesday": "Focus on personal growth and development.",
      "Thursday": "Be open to new opportunities that come your way.",
      "Friday": "Your creativity knows no bounds today; express yourself freely.",
      "Saturday": "Connect with friends and enjoy social activities.",
      "Sunday": "Take some time for self-reflection and relaxation."
    },
    "Taurus": {
      "Monday": "Financial matters are favorable; make wise investments.",
      "Tuesday": "Enjoy the simple pleasures in life and relax.",
      "Wednesday": "Your determination will help you achieve your goals.",
      "Thursday": "Focus on your health and well-being today.",
      "Friday": "Your practicality and reliability are admired by others.",
      "Saturday": "Spend time with loved ones and nurture your relationships.",
      "Sunday": "Embrace your artistic side and indulge in creative activities."
    },
    "Gemini": {
      "Monday": "Socialize and connect with friends for exciting opportunities.",
      "Tuesday": "Embrace learning and communication today.",
      "Wednesday": "Express your creative side and try something new.",
      "Thursday": "Your adaptability shines in challenging situations.",
      "Friday": "Networking and social interactions bring new prospects.",
      "Saturday": "Take a short trip and explore new places.",
      "Sunday": "Spend quality time with your family and loved ones."
    },
    "Cancer": {
      "Monday": "Your intuition guides you to make wise decisions.",
      "Tuesday": "Nurture your relationships and express your emotions.",
      "Wednesday": "Focus on creating a harmonious home environment.",
      "Thursday": "Your caring nature brings comfort to those around you.",
      "Friday": "Trust your instincts in financial matters.",
      "Saturday": "Connect with nature and find solace in the outdoors.",
      "Sunday": "Pamper yourself and indulge in self-care activities."
    },
    "Leo": {
      "Monday": "Your confidence and charisma attract positive opportunities.",
      "Tuesday": "Share your creative ideas; others will be inspired.",
      "Wednesday": "Express your love and appreciation to your loved ones.",
      "Thursday": "Your leadership skills shine in group activities.",
      "Friday": "Celebrate your achievements and bask in the spotlight.",
      "Saturday": "Enjoy a day of leisure and relaxation.",
      "Sunday": "Engage in activities that bring you joy and fulfillment."
    },
    "Virgo": {
      "Monday": "Your attention to detail impresses others; focus on your work.",
      "Tuesday": "Organize your tasks and prioritize your responsibilities.",
      "Wednesday": "Embrace a health-conscious routine and well-balanced diet.",
      "Thursday": "Your analytical skills help solve complex problems.",
      "Friday": "Spend time decluttering and creating an organized space.",
      "Saturday": "Engage in creative hobbies and express your artistic side.",
      "Sunday": "Connect with your spiritual self and find inner peace."
    },
    "Libra": {
      "Monday": "Balance your personal and professional life for harmony.",
      "Tuesday": "Express your creativity through artistic endeavors.",
      "Wednesday": "Spend quality time with loved ones and strengthen bonds.",
      "Thursday": "Engage in diplomatic communication to resolve conflicts.",
      "Friday": "Indulge in activities that bring you joy and relaxation.",
      "Saturday": "Seek beauty in your surroundings and appreciate the arts.",
      "Sunday": "Practice self-love and self-care; pamper yourself."
    },
    "Scorpio": {
      "Monday": "Your determination and intensity drive you towards success.",
      "Tuesday": "Trust your instincts in decision-making; they won't fail you.",
      "Wednesday": "Embrace your transformative abilities and seek self-improvement.",
      "Thursday": "Your mysterious aura captivates those around you.",
      "Friday": "Face challenges with courage and unwavering resolve.",
      "Saturday": "Channel your passion into creative pursuits.",
      "Sunday": "Reflect on your goals and set intentions for the future."
    },
    "Sagittarius": {
      "Monday": "Your optimism and enthusiasm bring positive energy to your day.",
      "Tuesday": "Embrace adventure and explore new horizons.",
      "Wednesday": "Share your knowledge and wisdom with others.",
      "Thursday": "Engage in open-minded conversations and broaden your perspectives.",
      "Friday": "Your curiosity leads you to exciting discoveries.",
      "Saturday": "Indulge in physical activities and outdoor adventures.",
      "Sunday": "Spend time with friends and engage in social activities."
    },
    "Capricorn": {
      "Monday": "Your discipline and determination pave the way for success.",
      "Tuesday": "Set practical goals and work diligently towards achieving them.",
      "Wednesday": "Focus on your financial stability and long-term investments.",
      "Thursday": "Your reliability earns the trust of those around you.",
      "Friday": "Plan for the future and make strategic decisions.",
      "Saturday": "Spend quality time with family and build strong bonds.",
      "Sunday": "Take a moment to relax and recharge; self-care is essential."
    },
    "Aquarius": {
      "Monday": "Your innovative ideas spark creativity and inspire others.",
      "Tuesday": "Engage in humanitarian efforts and make a positive impact.",
      "Wednesday": "Connect with like-minded individuals and expand your network.",
      "Thursday": "Embrace your unique perspective and stand out from the crowd.",
      "Friday": "Explore unconventional methods and embrace change.",
      "Saturday": "Indulge in artistic pursuits and express your creativity.",
      "Sunday": "Focus on your mental well-being; practice mindfulness."
    },
    "Pisces": {
      "Monday": "Trust your intuition and let your creativity flow.",
      "Tuesday": "Nurture your spiritual side and connect with your inner self.",
      "Wednesday": "Express your empathy and compassion towards others.",
      "Thursday": "Find solace in nature and seek tranquility.",
      "Friday": "Engage in acts of kindness and spread love to those around you.",
      "Saturday": "Embrace your artistic talents and create something beautiful.",
      "Sunday": "Reflect on your dreams and aspirations; set intentions for the future."
    }
  };

  Color getColorByName(String colorName) {
    switch (colorName.toLowerCase()) {
      case "red":
        return Colors.red;
      case "green":
        return Colors.green;
      case "blue":
        return Colors.blue;
      case "orange":
        return Colors.orange;
      case "yellow":
        return Colors.yellowAccent;
      case "silver":
        return Colors.grey; // Change to grey or the desired color
      case "gold":
        return Colors.yellow; // Adjust to the appropriate shade of gold
      case "brown":
        return Colors.brown; // Adjust to the appropriate shade of beige
      case "pink":
        return Colors.pink;
      case "black":
        return Colors.black;
      case "dark red":
        return Colors.red; // Adjust to the appropriate shade of dark red
      case "bright blue":
        return Colors.blue; // Adjust to the appropriate shade of bright blue
      case "gray":
        return Colors.grey;
      case "dark green":
        return Colors.greenAccent; // Adjust to the appropriate shade of dark green
      case "electric blue":
        return Colors.blueGrey; // Adjust to the appropriate shade of electric blue
      case "seafoam green":
        return Colors.lightGreen; // Adjust to the appropriate shade of seafoam green
      case "lavender":
        return Colors.purple;
      case "beige":
        return Color(0xfff5f5dc);
      case "pastels":
        return Color(0xffd4ffea);// Adjust to the appropriate shade of lavender
      default:
        return Colors.grey; // Default color if not found
    }
  }



  final Map<String, String> moodData = {
    "Aries": "You may feel confident and assertive today.",
    "Taurus": "A calm and stable mood is in store for you.",
    "Gemini": "Your mood is adaptable and communicative today.",
    "Cancer": "Your mood is nurturing and empathetic.",
    "Leo": "You're in a vibrant and enthusiastic mood.",
    "Virgo": "You're feeling practical and organized today.",
    "Libra": "Your mood is balanced and harmonious.",
    "Scorpio": "You're in an intense and passionate mood.",
    "Sagittarius": "You're in an adventurous and optimistic mood.",
    "Capricorn": "You're feeling disciplined and determined today.",
    "Aquarius": "Your mood is unique and original.",
    "Pisces": "You're in a dreamy and imaginative mood.",
  };

  final Map<String, List<String>> colorPreferences = {
    "Aries": ["Red", "Orange"],
    "Taurus": ["Green", "Brown"],
    "Gemini": ["Yellow", "Silver"],
    "Cancer": ["Blue", "Silver"],
    "Leo": ["Gold", "Purple"],
    "Virgo": ["Beige", "Pastels"],
    "Libra": ["Pink", "Light Blue"],
    "Scorpio": ["Black", "Dark Red"],
    "Sagittarius": ["Bright Blue", "Purple"],
    "Capricorn": ["Gray", "Dark Green"],
    "Aquarius": ["Electric Blue", "Silver"],
    "Pisces": ["Seafoam Green", "Lavender"],
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zodiac Outfit and Horoscope"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedZodiacSign,
              items: zodiacData.keys.map((String zodiac) {
                return DropdownMenuItem<String>(
                  value: zodiac,
                  child: Text(zodiac),
                );
              }).toList(),
              onChanged: (String? newZodiacSign) {
                if (newZodiacSign != null) {
                  setState(() {
                    selectedZodiacSign = newZodiacSign;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            // Display the list of colors horizontally
            Container(
              height: 50, // Adjust the height as needed
              child: Center( // Wrap the Container in a Center widget
                child: Row( // Wrap the ListView with a Row
                  mainAxisAlignment: MainAxisAlignment.center, // Center-align the children
                  children: colorPreferences[selectedZodiacSign]?.map((String color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: 50, // Adjust the width as needed
                        height: 50, // Adjust the height as needed
                        decoration: BoxDecoration(
                          color: getColorByName(color),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: selectedColor == color
                              ? Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      ),
                    );
                  })?.toList() ?? [],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Outfit Recommendations for $selectedZodiacSign:",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              zodiacData[selectedZodiacSign] ??
                  "No outfit recommendations available for this zodiac sign.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Daily Horoscope for $selectedZodiacSign:",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Text(
              dailyHoroscope[selectedZodiacSign]?["Monday"] ??
                  "No horoscope available for this day.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Mood for $selectedZodiacSign:",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              moodData[selectedZodiacSign] ??
                  "Mood information not available for this sign.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
