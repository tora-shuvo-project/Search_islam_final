import 'package:flutter/material.dart';
import 'package:search_islam/data/model/janun_model.dart';
import 'package:search_islam/helper/firestore_database_helper.dart';
import 'package:search_islam/view/widget/custom_button.dart';

List<JanunModel> janunList = [
  JanunModel(id: 101, title: 'অধীনস্তদের সঙ্গে রাসূল সাল্লাল্লাহু আলাইহি ওয়াসাল্লাম এর ব্যবহার:', description: 'নবী (সাল্লালাহু আ'),
  JanunModel(id: 102, title: 'আল্লাহ কোথায় ?', description: 'নবী (সাল্লালাহুয়:'),
  JanunModel(id: 103, title: 'বিজ্ঞানের সাথে আল্লাহর পথে', description: 'নবী (সাল্লালাহুয়:'),
];

List<JanunModelNosihat> nosihatList = [
  JanunModelNosihat(id: 101, title: '“তিনটি গুণাবলী সবরের (ধৈর্য) অন্তর্ভুক্ত: নিজের দুর্দশার ব্যাপারে কথা না বলা, নিজের কষ্ট (সম্পর্কে কথা না বলা) এবং নিজের প্রশংসা না করা।”', reference: '[আল-হিলইয়াহ, ৬/৩৮৯]'),
  JanunModelNosihat(id: 102, title: '“জ্ঞান অর্জন করো। যখন তুমি জ্ঞানার্জন করবে, তখন তা দৃঢ়ভাবে ধরে রাখ এবং তাকে পালাতে দিয়ো না। হাসিঠাট্টা আর খেলার সাথে জ্ঞানকে মিশ্রিত করো না; নইলে তোমার হৃদয় তার ভেতর থেকে তোমার অর্জিত জ্ঞানকে উগড়ে ফেলে দেবে।”', reference: '– সুফিয়ান আস-সাওরি (রাহিমাহুল্লাহ)[বায়োগ্রাফি অফ সুফিয়ান আস-সাওরি, পৃ ১৫২]'),
  JanunModelNosihat(id: 103, title: 'সেই মানুষকে দেখে আমি বিষ্মিত হই যিনি কুরআন তিলাওয়াত করেন অথচ তার ব্যাখ্যা জানেন না। এমন একজন মানুষ কী করে তার তিলাওয়াতে কোন আনন্দ পেতে পারে?', reference: '– ইমাম আত-তাবারী (রাহিমাহুল্লাহ) [মৃত্যু ৩১৪ হিজরী, বাগদাদ]'),
  JanunModelNosihat(id: 104, title: '"দুনিয়ার মানুষকে খুশি করা কঠিন, খুশি রাখা আরো কঠিন। আর আল্লাহ তায়ালাকে খুশি করা খুবই সহজ, খুশি রাখা আরো বেশি সহজ।"', reference: '--ড. আব্দুল্লাহ জাহাঙ্গীর (রাহিমাহুল্লাহ)'),
  JanunModelNosihat(id: 105, title: '"মানুষের সাথে কোমল ব্যবহার এবং তাদের জন্য কল্যাণ কামনার চেয়ে কলবের (অন্তরের) জন্যে অধিক উপকারী আর কিছু নেই।"🌸', reference: '— ইমাম ইবনুল কায়্যিম (রহ.)[মাদারিজুস সালিকিন, ২/৫১১]'),
  JanunModelNosihat(id: 106, title: ' সেই বৃক্ষের মতন হও যখন লোকে তাকে পাথর ছুড়ে দেয়, সে তার বিনিময়ে দেয় সুস্বাদু ফল। ❤️', reference: '-ইমাম হাসান আল বান্না(রাহিমাহুল্লাহ)'),
  JanunModelNosihat(id: 107, title: '"তাহাজ্জুদ নামাজের সিজদায় গিয়ে নিজের ইচ্ছাগুলো প্রকাশ করুন। কারণ এইসময় সবচেয়ে বেশি দুয়া কবুল হয়"💖', reference: '(বুখারী শরীফ, ১১৪৬)'),
  JanunModelNosihat(id: 108, title: 'আহার কর এবং পান কর, কিন্তু অপচয় করো না। কারণ আল্লাহ্‌ অপচয়কারীকে ভালোবাসেন না। ', reference: '( সূরা আল্‌-আ\'রাফ-৩১)'),
  JanunModelNosihat(id: 109, title: '', reference: '— ইমাম ইবনুল কাইয়্যুম রহিমাহুল্লাহু [হুকমু ত্বরিকুস সালাত, পৃষ্ঠা: ১০৫]'),
  JanunModelNosihat(id: 110, title: '', reference: 'ফুটনোটঃ-\n১)বুখারী হা/৫০১৩,৬৬৪৩,৭৩৭৪\n২)বুখারী,মুসলিম হা/৮১১\n৩)বুখারী হা/৭৩৭৫,মুসলিম হা/৮১৩\n৪)সহীহুল জা’মে হা/ ৬৪৭২'),
  JanunModelNosihat(id: 111, title: '"দোয়া কবুল হবে, এই বিশ্বাস রেখে দোয়া করো,কেননা,আল্লাহ তাআলা কোন উদাসীন অন্তরের দোয়া কবুল করেন না।"🌻', reference: '[ তিরমিযীঃ- ৩৪৭৯ ]'),
  JanunModelNosihat(id: 112, title: 'যদি কখনো মনে অহংকার আশা শুরু করে,তাহলে কবরস্থানে ঘুরে আসুন ওখানে আপনার চেয়েও জ্ঞানী,সুন্দর ও ধনী মানুষ জন মাটির নিচে শুয়ে আছে।', reference: ''),
  JanunModelNosihat(id: 113, title: '', reference: ''),
  JanunModelNosihat(id: 114, title: '', reference: ''),
  JanunModelNosihat(id: 115, title: 'রাসুলুল্লাহ ﷺ ব‌লেন যেখানেই নামাজের সময় এসে উপস্থিত হবে সেখানেই তোমরা নামাজ আদায় করে নিবে।', reference: '[সহীহ_বুখারী৩২৪৩]'),
  JanunModelNosihat(id: 116, title: 'রাসূলুল্লাহ(সাঃ)ﷺএরশাদ করেন🔹 ‘তোমাদের সন্তানদের সাত বছর হলে তাদের নামাজের আদেশ দাও,এবং পবিত্র কুরআন শিক্ষা দাও ', reference: '[আবূ_দাউদ : ৪৯৫]'),
  JanunModelNosihat(id: 117, title: '', reference: ''),
  JanunModelNosihat(id: 118, title: 'নবীজি বলেছেন,‘‘যে ব্যক্তি আল্লাহের সন্তুষ্টির জন্য একটি মসজিদ নির্মাণ করে,আল্লাহ তার জন্য জান্নাতে একটি ঘর তৈরী করেন’’', reference: '(বুখারী ৪৫০)'),
  JanunModelNosihat(id: 119, title: 'চরিত্র রক্ষার জন্য যারা বিয়ে করবে তারা যদি অভাবি হয়, তবে আল্লাহ  নিজ অনুগ্রহে তাদেরকে অভাবমুক্ত করে দিবেন। ', reference: '(সুরা নুর : ৩২)'),
  JanunModelNosihat(id: 120, title: 'তোমরা সিজদায় বেশি বেশি দোয়া করো,  কেননা সিজদা হচ্ছে দোয়া কবুলের উপযুক্ত সময়। ', reference: '(মুসলিমঃ৮৭৩)'),
  JanunModelNosihat(id: 121, title: 'যে বাড়িতে নিয়মিত মাগরিবের নামাজের পর সূরা ওয়াকিয়া তেলাওয়াত করা হয়,,ঐ বাড়িতে কোনদিন রুজির অভাব হবে না।।', reference: 'হযরত মুহাম্মদ (সাঃ)।'),
  JanunModelNosihat(id: 122, title: '~ `অবশ্যই তুমি পাবে যা চলে গেছে তার থেকে ও উত্তম"', reference: '__হযরত মুহাম্মদ (সাঃ)'),
  JanunModelNosihat(id: 123, title: '', reference: ''),
  JanunModelNosihat(id: 124, title: '', reference: ''),
  JanunModelNosihat(id: 125, title: '“যে ব্যক্তি আল্লাহর উপর ভরসা করে তার জন্য তিনিই যথেষ্ট।”', reference: '(সূরা ত্বালাক-৩)'),
  JanunModelNosihat(id: 126, title: 'মাটি থেকেই আমি তোমাদেরকে সৃষ্টি করেছি, মাটিতেই আমি তোমাদের ফিরিয়ে নেব এবং এ মাটি থেকেই তোমাদেরকে পুনরায় বের করে আনবো।”', reference: '—[সূরা-ত্বাহাঃ→ ৫৫]'),
  JanunModelNosihat(id: 127, title: 'মানুষ কে খুশি করা খুব কঠিন, আল্লাহ্‌ কে খুশি করা সবচেয়ে সহজ..', reference: ''),
  JanunModelNosihat(id: 128, title: '"যার হৃদয়ে বিন্দু পরিমাণ অহংকার আছে, সেই ব্যক্তি কোনোদিন বেহেশতে প্রবেশ করবে না"', reference: '- মহানবী হযরত মুহাম্মদ (সাঃ)'),
  JanunModelNosihat(id: 129, title: '#আল্লাহ_পাক_বলেনঃ নিশ্চয়ই যারা দৃষ্টির অগোচরে তাদের রবকে ভয় করে চলে, তাদের জন্য রয়েছে ক্ষমা ও মহাপূরষ্কার।', reference: '[সুরা মূলকঃ ১২]'),
  JanunModelNosihat(id: 130, title: ' যারা আল্লাহকে অধিক পরিমাণে স্মরণ করে আল্লাহ তাদের জন্য রেখেছেন ক্ষমা ও বিরাট পুরষ্কার ।', reference: '---{ সূরা আল আযহাবঃ ৩৫}'),
  JanunModelNosihat(id: 131, title: 'আল্লাহ তা,আলা বলেন  "যখন কোনো প্রার্থনাকারী আমার কাছে প্রার্থনা করে তখন আমি তার প্রার্থনা কবুল করি।"', reference: '–[সূরা আল বাকারা: ১৩৬]'),
  JanunModelNosihat(id: 132, title: 'আল্লাহ তা\'য়ালা মুমিনদের জান-মাল ক্রয় করে নিয়েছেন জান্নাতের বিনিময়ে" 🙂', reference: '“সুরা তওবাহ -১১১”'),
  JanunModelNosihat(id: 133, title: '“যদি আল্লাহর ভালোবাসা পেতে চাও, তবে রাসূলের অনুসরণ করো।”', reference: '____[সূরা ইমরানঃ→ ৩১'),
  JanunModelNosihat(id: 134, title: 'মহান আল্লাহ তায়ালা বলেন- তোমরা চিন্তিত হয়ো না, ভয় পেয়োনা, তোমরাই বিজয়ী হবে যদি তোমরা মুমিন হও।"', reference: '..........(( সূরা ইমরান ১৩৯))'),
  JanunModelNosihat(id: 135, title: '', reference: '_______(-সূরা ইউসুফঃ- ৮৬-).________'),
  JanunModelNosihat(id: 136, title: '', reference: '_____ [সূরা ইউনুসঃ ৪৪] _______'),
  JanunModelNosihat(id: 137, title: 'আল্লাহ পাকে ঘোষণা, ‘নিশ্চয় আমি তোমাদেরকে কিছু ভয় ও ক্ষুধা দ্বারা, কিছু সম্পদ ও প্রাণ দ্বারা এবং ফসলের ক্ষতি দ্বারা পরীক্ষা করব।’', reference: '(সুরা বাকারা : আয়াত ১৫৫)'),
  JanunModelNosihat(id: 138, title: '', reference: '____মহানবী হযরত মোহাম্মদ (সঃ)'),
  JanunModelNosihat(id: 139, title: '', reference: '----------(ইমাম উমর সুলাইমান)'),
  JanunModelNosihat(id: 140, title: '', reference: ''),
  JanunModelNosihat(id: 141, title: 'মহান আল্লাহ বলেন: নিশ্চয় যারা ঈমান এনেছে ও নেক আমল করেছে তারাই সৃষ্টির শ্রেষ্ঠ।', reference: '(সূরা বাইয়্যিনাহ ৭)'),
  JanunModelNosihat(id: 142, title: 'রাসূল (সাঃ) বলেন- \'যে যুবক-যুবতী যৌবনে আল্লাহর ইবাদতে লিপ্ত থাকবে, আল্লাহ তা\'য়ালা তাকে আরশে পাকের ছায়া তলে আশ্রয় দান করবেন।', reference: '____📕[সহীহ বুখারী-৬৮০৬]'),
  JanunModelNosihat(id: 143, title: '"জাহান্নামের আগুন নিভানোর জন্য, আল্লাহর ভয়ে চোখের এক ফোঁটা অশ্রুই যথেষ্ঠ।"', reference: '—বিশ্বনবী হযরত মোহাম্মদ (সাঃ)'),

];

class TestScreen extends StatefulWidget {
  const TestScreen({Key key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  addData() {
    for (var value in nosihatList) {
      FirestoreDatabaseHelper.addNosihatToFirebase(value,4).then((_) {
        setState(() {
          print(value.id);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          CustomButton(
            buttonText: 'save ',
            onTap: addData,
          )
        ],
      ),
    );
  }
}
