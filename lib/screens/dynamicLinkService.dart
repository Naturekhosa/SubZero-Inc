import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// this classs create the dynamic link
class dynamicLinkService{
  static Future<String> createdynamicLink(String itemName) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
  link: Uri.parse("https://www.swap_shop.com"),
  uriPrefix: "https://subzeroinc.page.link/start",
  androidParameters: const AndroidParameters(
    packageName: "com.example.swap_shop",
    minimumVersion: 30,
  ),
    );
   Uri url;

   
   final ShortDynamicLink  shortlink = await FirebaseDynamicLinks.instance.buildShortLink(parameters) ;
   
   url = shortlink.shortUrl;
   




   return url.toString();




  }
}








  
