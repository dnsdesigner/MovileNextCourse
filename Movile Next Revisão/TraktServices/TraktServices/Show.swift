//
//  Show.swift
//  TraktServices
//
//  Created by Dennis de Oliveira on 21/06/15.
//  Copyright (c) 2015 Dennis de Oliveira. All rights reserved.
//

import Argo
import Runes
import ISO8601DateFormatter

// Cria uma struct para representar Identifiers
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
    
    // Cria um array de decode
    public static func decode(json: JSON) -> Decoded<Identifiers> {
        return Identifiers.create
            <^> json <| "trakt"
            <*> json <|? "tvdb"
            <*> json <|? "imdb"
            <*> json <|? "tmdb"
            <*> json <|? "tvrage"
            <*> json <|? "slug"
    }
    
}

// Cria um enum para representar ShowStatus na struct principal
public enum ShowStatus: String {
    case Returning = "returning series"
    case InProduction = "in production"
    case Canceled = "canceled"
    case Ended = "ended"
}

extension ShowStatus: Decodable {
    public static func decode(json: JSON) -> Decoded<ShowStatus> {
        switch json {
        case let .String(rawValue): return .fromOptional(ShowStatus(rawValue: rawValue))
        default: return .TypeMismatch("\(json) is not a String") // Provide an Error message for a string type mismatch
        }
    }
}

// Struct para representar as imagens
public struct ImagesURLs {
    public let fullImageURL: NSURL?
    public let mediumImageURL: NSURL?
    public let thumbImageURL: NSURL?
}

// Struct auxiliar para transformar a URL
struct JSONParseUtils {
    static func parseURL(URLString: String?) -> Decoded<NSURL?> {
        return pure(flatMap(URLString) { NSURL(string: $0) })
    }
}

extension NSDate: Decodable {
    class DateFormatterWrapper {
        static let dateFormatter = ISO8601DateFormatter()
    }
    
    public static func decode(json: JSON) -> Decoded<NSDate> {
        switch json {
        case let .String(rawValue): return .fromOptional(DateFormatterWrapper.dateFormatter.dateFromString(rawValue))
        default: return .TypeMismatch("\(json) is not a String") // Provide an Error message for a string type mismatch
        }
    }
}

extension ImagesURLs: Decodable {
    static func create(fullImageURL: NSURL?)(mediumImageURL: NSURL?)(thumbImageURL: NSURL?) -> ImagesURLs {
        return ImagesURLs(fullImageURL: fullImageURL, mediumImageURL: mediumImageURL, thumbImageURL: thumbImageURL)
    }
    
    public static func decode(json: JSON) -> Decoded<ImagesURLs> {
        return ImagesURLs.create
            <^> (json <|? "full"   >>- JSONParseUtils.parseURL)
            <*> (json <|? "medium" >>- JSONParseUtils.parseURL)
            <*> (json <|? "thumb"  >>- JSONParseUtils.parseURL)
    }
}

// struct principal para representar o modelo de dados do Show que virá de um JSON
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
    
    public static func decode(json: JSON) -> Decoded<Show> {
        let s1 = Show.create
            <^> json <| "title"
            <*> json <| "year"
            <*> json <| "ids"
            <*> json <|? "overview"
            <*> json <|? "first_aired"
            <*> json <|? "runtime"
            <*> json <|? "network"
            <*> json <|? "country"
            <*> (json <|? "trailer" >>- JSONParseUtils.parseURL)
        
        let s2 = s1
            <*> (json <|? "homepage" >>- JSONParseUtils.parseURL)
            <*> json <|? "status"
            <*> json <|? "rating"
            <*> json <|? "votes"
            <*> json <||? "genres"
            <*> json <|? "aired_episodes"
        
        return s2
            <*> json <|? ["images", "fanart"]
            <*> json <|? ["images", "poster"]
            <*> (json <|? ["images", "logo", "full"] >>- JSONParseUtils.parseURL)
            <*> (json <|? ["images", "clearart", "full"] >>- JSONParseUtils.parseURL)
            <*> (json <|? ["images", "banner", "full"] >>- JSONParseUtils.parseURL)
            <*> (json <|? ["images", "thumb", "full"] >>- JSONParseUtils.parseURL)
    }
}
