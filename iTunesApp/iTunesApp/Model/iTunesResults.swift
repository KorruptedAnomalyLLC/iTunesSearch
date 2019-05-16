//
//  iTunesResults.swift
//  iTunesApp
//
//  Created by Austin West on 5/16/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import Foundation

struct TopLevelJSON: Codable {
    let results: [iTunesResults]
}

struct iTunesResults: Codable {
    
    let artist: String
    let track: String
    let album: String
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        case track = "trackName"
        case album = "collectionName"
        case imageURL = "artworkUrl30"
    }
}
