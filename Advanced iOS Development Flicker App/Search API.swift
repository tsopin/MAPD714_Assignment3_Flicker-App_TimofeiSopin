//
//  Search API.swift
//  Advanced iOS Development Flicker App
//
//  Created by Timofei Sopin on 2018-03-12.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit

class SearchAPI {
    
    typealias FlickrResponse = (NSError?, [ImageSearching]?) -> Void
    
    struct Keys {
        static let flickrKey = "a06b379325ac35c721b81b9abbdd4617"
    }
    
    struct Errors {
        static let invalidAccessErrorCode = 100
    }
    
    class func fetchPhotosForSearchText(searchText: String, onCompletion: @escaping FlickrResponse) -> Void {
        let escapedSearchText: String = searchText.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Keys.flickrKey)&text=\(escapedSearchText)&format=json&nojsoncallback=1"
        let url: NSURL = NSURL(string: urlString)!
        let searchTask = URLSession.shared.dataTask(with: url as URL, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                print("Error fetching photos: \(String(describing: error))")
                onCompletion(error as NSError?, nil)
                return
            }
            
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                guard let results = resultsDictionary else { return }
                
                if let statusCode = results["code"] as? Int {
                    if statusCode == Errors.invalidAccessErrorCode {
                        let invalidAccessError = NSError(domain: "com.flickr.api", code: statusCode, userInfo: nil)
                        onCompletion(invalidAccessError, nil)
                        return
                    }
                }
                
                guard let photosContainer = resultsDictionary!["photos"] as? NSDictionary else { return }
                guard let photosArray = photosContainer["photo"] as? [NSDictionary] else { return }
                
                let flickrPhotos: [ImageSearching] = photosArray.map { photoDictionary in
                    
                    let photoId = photoDictionary["id"] as? String ?? ""
                    let farm = photoDictionary["farm"] as? Int ?? 0
                    let secret = photoDictionary["secret"] as? String ?? ""
                    let server = photoDictionary["server"] as? String ?? ""
                    let title = photoDictionary["title"] as? String ?? ""
                    
                    let flickrPhoto = ImageSearching(photoId: photoId, farm: farm, secret: secret, server: server, title: title)
                    return flickrPhoto
                }
                
                onCompletion(nil, flickrPhotos)
                
            } catch let error as NSError {
                print("Error parsing JSON: \(error)")
                onCompletion(error, nil)
                return
            }
            
        })
        searchTask.resume()
    }
    
}
