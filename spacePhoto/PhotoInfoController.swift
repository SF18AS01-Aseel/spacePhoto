//
//  PhotoInfoController.swift
//  spacePhoto
//
//  Created by Aseel Alshohatee on 3/19/19.
//  Copyright © 2019 Aseel Alshohatee. All rights reserved.
//

import Foundation;

struct PhotoInfoController {
    
    // the method that has all the networking
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {   //p. 880
        
        guard let baseURL: URL = URL(string: "https://api.nasa.gov/planetary/apod") else {
            print("could not create baseURL");
            completion(nil);
            return;
        }
        
        let query: [String: String] = [
            "api_key": "DEMO_KEY",
            //"date":    "2019-02-26"   //a date with a video, p. 890
        ];
        
        guard let url: URL = baseURL.withQueries(query) else {
            print("could not create url");
            completion(nil);
            return;
        }
        // to get our hand on the data 
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            let jsonDecoder: JSONDecoder = JSONDecoder();
            
            guard let data: Data = data else {
                print("no data was returned");
                completion(nil);
                return;
            }
            
            guard let string: String = String(data: data, encoding: .utf8) else {
                print("could not change Data into String");
                completion(nil);
                return;
            }
            print(string);
            
            guard let photoInfo: PhotoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) else {
                print("data was not serialized");
                completion(nil);
                return;
            }
            
            completion(photoInfo);
        }
        
        task.resume();
    }
    
}
