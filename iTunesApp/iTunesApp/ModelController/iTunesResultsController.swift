//
//  iTunesResultsController.swift
//  iTunesApp
//
//  Created by Austin West on 5/16/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import UIKit

class iTunesResultsController {
    
    static let baseURL = URL(string: "https://itunes.apple.com/")
    
    static func searchItunesFor(searchTerm: String, completion: @escaping ([iTunesResults]) -> Void) {
        guard var url = baseURL else { completion([]); return }
        
        url.appendPathComponent("search")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let termQuery = URLQueryItem(name: "term", value: searchTerm)
        let musicQuery = URLQueryItem(name: "media", value: "music")
        
        components?.queryItems = [termQuery, musicQuery]
        
        guard let finalURL = components?.url else { completion([]); return }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error fetching items for search term \(searchTerm) : \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else { completion([]); return}
            
            let decoder = JSONDecoder()
            
            do {
                let topLevelJSON = try decoder.decode(TopLevelJSON.self, from: data)
                let iTunesResults = topLevelJSON.results
                completion(iTunesResults)
                
            } catch {
                print("lsfdgkjf error ddecoding itunes results \(error.localizedDescription)")
                completion([])
                return
            }
            }.resume()
    }
    static func fetchImageFor(iTunesResult: iTunesResults, completion: @escaping (UIImage?) -> Void) {
        guard let url = iTunesResult.imageURL else { completion(nil); return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching image for iTunes result \(iTunesResult.track) : \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil); return }
            
            let image = UIImage(data: data)
            completion(image)
//            Don't forget
        }.resume()
    }
}
