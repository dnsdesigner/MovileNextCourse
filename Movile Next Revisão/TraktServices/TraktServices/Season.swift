//
//  Season.swift
//  TraktServices
//
//  Created by Dennis de Oliveira on 22/06/15.
//  Copyright (c) 2015 Dennis de Oliveira. All rights reserved.
//

import Foundation
import Argo
import Runes

public struct Season {
    public let number: Int
    public let identifiers: Identifiers?
    public let rating: Float?
    public let votes: Int?
    public let episodeCount: Int?
    public let airedEpisodes: Int?
    public let overview: String?
    public let poster: ImagesURLs?
    public let thumbImageURL: NSURL?
}

extension Season: Decodable {
    static func create(number: Int)(identifiers: Identifiers?)(rating: Float?)(votes: Int?)(episodeCount: Int?)(airedEpisodes: Int?)
        (overview: String?)(poster: ImagesURLs?)(thumbImageURL: NSURL?) -> Season {
            return Season(number: number, identifiers: identifiers, rating: rating, votes: votes, episodeCount: episodeCount,
                airedEpisodes: airedEpisodes, overview: overview, poster: poster, thumbImageURL: thumbImageURL)
    }
    
    public static func decode(j: JSON) -> Decoded<Season> {
        
        return Season.create
            <^> j <| "number"
            <*> j <|? "ids"
            <*> j <|? "rating"
            <*> j <|? "votes"
            <*> j <|? "episode_count"
            <*> j <|? "aired_episodes"
            <*> j <|? "overview"
            <*> j <|? ["images", "poster"]
            <*> (j <|? ["images", "thumb", "full"]  >>- JSONParseUtils.parseURL)
    }
}