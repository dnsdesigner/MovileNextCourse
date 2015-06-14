//
//  Episode.swift
//  movile-up-ios
//
//  Created by Marcelo Fabri on 16/04/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import Argo
import Runes
import ISO8601DateFormatter

public struct Identifiers {
    public let trakt: Int
    public let tvdb: Int?
    public let imdb: String?
    public let tmdb: Int?
    public let tvrage: Int?
    public let slug: String?
}

extension Identifiers: Decodable {
    static func create(trakt: Int)(tvdb: Int?)(imdb: String?)(tmdb: Int?)(tvrage: Int?)(slug: String?) -> Identifiers {
        return Identifiers(trakt: trakt, tvdb: tvdb, imdb: imdb, tmdb: tmdb, tvrage: tvrage, slug: slug)
    }
    
    public static func decode(j: JSON) -> Decoded<Identifiers> {
        return Identifiers.create
            <^> j <| "trakt"
            <*> j <|? "tvdb"
            <*> j <|? "imdb"
            <*> j <|? "tmdb"
            <*> j <|? "tvrage"
            <*> j <|? "slug"        
    }
}

struct JSONParseUtils {
    static func parseURL(URLString: String?) -> Decoded<NSURL?> {
        return pure(flatMap(URLString) { NSURL(string: $0) })
    }
}

extension NSDate: Decodable {
    class DateFormatterWrapper {
        static let dateFormatter = ISO8601DateFormatter()
    }
    
    public static func decode(j: JSON) -> Decoded<NSDate> {
        switch j {
        case let .String(s): return .fromOptional(DateFormatterWrapper.dateFormatter.dateFromString(s))
        default: return .TypeMismatch("\(j) is not a String") // Provide an Error message for a string type mismatch
        }
    }
}

public struct ImagesURLs {
    public let fullImageURL: NSURL?
    public let mediumImageURL: NSURL?
    public let thumbImageURL: NSURL?
}

extension ImagesURLs: Decodable {
    static func create(fullImageURL: NSURL?)(mediumImageURL: NSURL?)(thumbImageURL: NSURL?) -> ImagesURLs {
        return ImagesURLs(fullImageURL: fullImageURL, mediumImageURL: mediumImageURL, thumbImageURL: thumbImageURL)
    }
    
    public static func decode(j: JSON) -> Decoded<ImagesURLs> {
        return ImagesURLs.create
            <^> j <|? "full" >>- JSONParseUtils.parseURL
            <*> j <|? "medium" >>- JSONParseUtils.parseURL
            <*> j <|? "thumb" >>- JSONParseUtils.parseURL
    }
}


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
    
    public static func decode(j: JSON) -> Decoded<Episode> {
        
        return Episode.create
            <^> j <| "number"
            <*> j <| "season"
            <*> j <|? "title"
            <*> j <|? "ids"
            <*> j <|? "overview"
            <*> j <|? "first_aired"
            <*> j <|? "rating"
            <*> j <|? "votes"
            <*> j <|? ["images", "screenshot"]
    }
}
