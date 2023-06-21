import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:m3u/m3u.dart';

Future<void> main() async {
  final fileContent = await File('assets/playlist.m3u8').readAsString();
  final listOfTracks = await parseFile(fileContent);
  if (kDebugMode) {
    print(listOfTracks);
  }

  // Organized categories
  final categories = sortedCategories(entries: listOfTracks, attributeName: 'group-title');
  if (kDebugMode) {
    print(categories);
  }
}

const fanheroM3u8Media = '''
#EXTM3U
#EXT-X-VERSION:6
#EXT-X-TARGETDURATION:7
#EXT-X-MEDIA-SEQUENCE:1
#EXT-X-PLAYLIST-TYPE:VOD
#EXT-X-MAP:URI="63dd499d47935de359e5a4f3_1675446685057_Cmaf_720pinit.cmfv"
#EXTINF:6,
63dd499d47935de359e5a4f3_1675446685057_Cmaf_720p_000000001.cmfv
#EXTINF:6,
63dd499d47935de359e5a4f3_1675446685057_Cmaf_720p_000000002.cmfv
#EXTINF:6,
63dd499d47935de359e5a4f3_1675446685057_Cmaf_720p_000000003.cmfv
#EXTINF:6,
63dd499d47935de359e5a4f3_1675446685057_Cmaf_720p_000000004.cmfv
#EXTINF:6,
63dd499d47935de359e5a4f3_1675446685057_Cmaf_720p_000000005.cmfv
#EXTINF:6,
63dd499d47935de359e5a4f3_1675446685057_Cmaf_720p_000000006.cmfv
#EXTINF:6,
63dd499d47935de359e5a4f3_1675446685057_Cmaf_720p_000000007.cmfv
#EXT-X-ENDLIST
''';

const playlist = '''
#EXTM3U
#EXT-X-VERSION:3
#EXT-X-TARGETDURATION:3
#EXT-X-MEDIA-SEQUENCE:0
#EXT-X-PLAYLIST-TYPE:VOD
#EXTINF:3.133333,
file_000.ts
#EXTINF:3.200000,
file_001.ts
#EXTINF:3.200000,
file_002.ts
#EXTINF:3.200000,
file_003.ts
#EXTINF:3.200000,
file_004.ts
#EXTINF:3.200000,
file_005.ts
#EXTINF:3.200000,
file_006.ts
#EXTINF:1.600000,
file_007.ts
#EXTINF:3.200000,
file_008.ts
#EXTINF:2.900000,
file_009.ts
#EXT-X-ENDLIST
''';
