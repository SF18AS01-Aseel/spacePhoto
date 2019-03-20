//
//  MyPlayground1.swift
//  spacePhoto
//
//  Created by Aseel Alshohatee on 3/19/19.
//  Copyright © 2019 Aseel Alshohatee. All rights reserved.
//
import Foundation;


// we going to get the info from the josn
struct PhotoInfo: Codable {   //p. 879
    var title: String;
    var description: String;
    var url: URL;
    var copyright: String?; // because we may not get it all the time
    var mediaType: String;   //p. 890
    
    enum Keys: String, CodingKey {
        case title;
        case description = "explanation";   //is explanation in the JSON
        case url;
        case copyright;
        case mediaType = "media_type";
    }
    
    //  to download a file and store it in struct
    init(from decoder: Decoder) throws {
        let valueContainer: KeyedDecodingContainer<Keys> = try decoder.container(keyedBy: Keys.self);
        title       = try  valueContainer.decode(String.self, forKey: Keys.title);
        description = try  valueContainer.decode(String.self, forKey: Keys.description);
        url         = try  valueContainer.decode(URL.self,    forKey: Keys.url);
        copyright   = try? valueContainer.decode(String.self, forKey: Keys.copyright);
        // try? give us a nil if ther copy rigt did not exist.
        mediaType   = try  valueContainer.decode(String.self, forKey: Keys.mediaType);
    }
}
