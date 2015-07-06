//
//  Episode.swift
//  TraktServices
//
//  Created by Dennis de Oliveira on 22/06/15.
//  Copyright (c) 2015 Dennis de Oliveira. All rights reserved.
//

import Argo
import Runes
import ISO8601DateFormatter

public struct Episode {
    public let number: Int
    public let seasonNumber: Int
    public let title: String?
    public let identifiers: Identifiers?
    public let overview: String?
    public let firstAired: NSDate?
    public let rating: Float?
    public let votes: Int?
    public let screenshot: ImagesURLs?
}

extension Episode: Decodable {
    static func create(number: Int)(seasonNumber: Int)(title: String?)(identifiers: Identifiers?)(overview: String?)(firstAired: NSDate?)
        (rating: Float?)(votes: Int?)(screenshot: ImagesURLs?) -> Episode {
            
            return Episode(number: number, seasonNumber: seasonNumber, title: title, identifiers: identifiers,
                overview: overview, firstAired: firstAired, rating: rating, votes: votes, screenshot: screenshot)
    }
    
    public static func decode(json: JSON) -> Decoded<Episode> {
        
        return Episode.create
            <^> json <| "number"
            <*> json <| "season"
            <*> json <|? "title"
            <*> json <|? "ids"
            <*> json <|? "overview"
            <*> json <|? "first_aired"
            <*> json <|? "rating"
            <*> json <|? "votes"
            <*> json <|? ["images", "screenshot"]
    }
}