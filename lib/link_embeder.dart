library link_embeder;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkEmbeder {
  static Future fetchMetadata(link) async {
    final myURL = link;

    // Use the `MetadataFetch.extract()` function from metadata_fetch package to fetch data from the url
    var data = await MetadataFetch.extract(myURL);

    print(data!.title); // Print the title of the page

    print(data.description); // Print the description of the page (if available)

    print(data.image); // Print the image of the page (if available)

    print(data.url); // Print the url of the page

    var dataAsMap = data.toMap();

    return data;
  }

  Future<List<Metadata?>> _fetchMetadata(link) =>
      Future.wait([MetadataFetch.extract(link)]);

  showEmbed(context, text) {
    // Extracts all the links from the text
    // and returns a list of links
    RegExp exp = new RegExp(
        r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?');
    Iterable<RegExpMatch> matches = exp.allMatches(text);

    matches.forEach((match) {
      print(text.substring(match.start, match.end));
    });

    // checks if the text contains any links
    // if it does, it returns a Widget
    // else it returns a empty container
    if (matches.isEmpty) {
      return Container();
    } else {
      var _link = text.substring(matches.first.start, matches.first.end);
      return FutureBuilder<List<Metadata?>>(
          future: _fetchMetadata(_link),
          builder: (context, AsyncSnapshot<List<Metadata?>> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () => launchlink(context, _link, _link),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 207, 207, 207),
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data!.first!.title!),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data!.first!.description!,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 82, 80, 80),
                                  fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            if (snapshot.data!.first!.image != null)
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          snapshot.data!.first!.image!,
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data!.first!.url!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 82, 80, 80),
                                  fontSize: 8),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ]),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          });
    }
  }

  // launch link in browser or app from url
  static launchlink(context, IosLink, AndriodLink) async {
    if (Platform.isIOS) {
      // Parsing string url to uri for iOS
      var _ioslink = Uri.parse(
        IosLink,
      );
      if (await canLaunchUrl(_ioslink)) {
        await launchUrl(_ioslink, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text('Unable to connect with the app')));
      }
    } else {
      // Parsing string url to uri for Android
      var android = Uri.parse(AndriodLink);
      if (await canLaunchUrl(android)) {
        await launchUrl(android, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text('Unable to connect with the app')));
      }
    }
  }
}
