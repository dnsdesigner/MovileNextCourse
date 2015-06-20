//
//  Show.swift
//  movile-up-ios
//
//  Created by Marcelo Fabri on 17/04/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import Argo
import Runes
import ISO8601DateFormatter

public enum ShowStatus: String {
    case Returning = "returning series"
    case InProduction = "in production"
    case Canceled = "canceled"
    case Ended = "ended"
}

extension ShowStatus: Decodable {
    public static func decode(j: JSON) -> Decoded<ShowStatus> {
        switch j {
        case let .String(s): return .fromOptional(ShowStatus(rawValue: s))
        default: return .TypeMismatch("\(j) is not a String") // Provide an Error message for a string type mismatch
        }
    }
}

public struct Show {
    public let title: String
    public let year: Int
    public let identifiers: Identifiers
    public let overview: String?
    public let firstAired: NSDate?
    public let runtime: Int?
    public let network: String?
    public let country: String?
    public let trailerURL: NSURL?
    public let homepageURL: NSURL?
    public let status: ShowStatus?
    public let rating: Float?
    public let votes: Int?
    public let genres: [String]?
    public let airedEpisodes: Int?
    public let fanart: ImagesURLs?
    public let poster: ImagesURLs?
    public let logoImageURL: NSURL?
    public let clearArtImageURL: NSURL?
    public let bannerImageURL: NSURL?
    public let thumbImageURL: NSURL?
}

extension Show: Decodable {
    
    // https://github.com/thoughtbot/Argo/issues/106
    static func create(title: String)(_ year: Int)(_ identifiers: Identifiers)(_ overview: String?)(_ firstAired: NSDate?)(_ runtime: Int?)(_ network: String?)
        (_ country: String?)(_ trailerURL: NSURL?)(_ homepageURL: NSURL?)(_ status: ShowStatus?)(_ rating: Float?)(_ votes: Int?)(_ genres: [String]?)
        (_ airedEpisodes: Int?)(_ fanart: ImagesURLs?)(_ poster: ImagesURLs?)(_ logoImageURL: NSURL?)(_ clearArtImageURL: NSURL?)
        (_ bannerImageURL: NSURL?)(_ thumbImageURL: NSURL?)
        -> Show {
            
        return Show(title: title, year: year, identifiers: identifiers, overview: overview, firstAired: firstAired, runtime: runtime,
            network: network, country: country, trailerURL: trailerURL, homepageURL: homepageURL, status: status, rating: rating, votes: votes, genres: genres,
            airedEpisodes: airedEpisodes, fanart: fanart, poster: poster, logoImageURL: logoImageURL, clearArtImageURL: clearArtImageURL,
            bannerImageURL: bannerImageURL, thumbImageURL: thumbImageURL)
    }
    
    public static func decode(j: JSON) -> Decoded<Show> {
        let s1 = Show.create
            <^> j <| "title"
            <*> j <| "year"
            <*> j <| "ids"
            <*> j <|? "overview"
            <*> j <|? "first_aired"
            <*> j <|? "runtime"
            <*> j <|? "network"
            <*> j <|? "country"
            <*> (j <|? "trailer" >>- JSONParseUtils.parseURL)
        
        let s2 = s1
            <*> (j <|? "homepage" >>- JSONParseUtils.parseURL)
            <*> j <|? "status"
            <*> j <|? "rating"
            <*> j <|? "votes"
            <*> j <||? "genres"
            <*> j <|? "aired_episodes"
        
        return s2
            <*> j <|? ["images", "fanart"]
            <*> j <|? ["images", "poster"]
            <*> (j <|? ["images", "logo", "full"] >>- JSONParseUtils.parseURL)
            <*> (j <|? ["images", "clearart", "full"] >>- JSONParseUtils.parseURL)
            <*> (j <|? ["images", "banner", "full"] >>- JSONParseUtils.parseURL)
            <*> (j <|? ["images", "thumb", "full"] >>- JSONParseUtils.parseURL)
    }
}

