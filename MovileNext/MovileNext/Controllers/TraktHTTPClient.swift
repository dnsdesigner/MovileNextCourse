//
//  TraktHTTPClient.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

// Trakt Keys
// Client ID: 19734df2d975560349c2d1b6bb9621bfdc2c2e3ef6023cbae7cfa71b938fbb79
// Client Secret: 47a9fafeb4cd9bdbc5f424bb207389cb57c6324f7ab1ef71a94b7223135f188a

import Alamofire
import Result
import TraktModels
import Argo

private enum Router: URLRequestConvertible {
    
    static let baseURLString = "https://api-v2launch.trakt.tv/"
    
    case Show(String)
    case Episode(showId: String, season: Int, episodeNumber: Int)
    case Popular
    
    // MARK: URLRequestConvertible
    var URLRequest: NSURLRequest {
        let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
            switch self {
                case .Show(let id):
                    return ("shows/\(id)", ["extended": "images,full"], .GET)
                case .Episode(let showId, let season, let episodeNumber):
                    return ("shows/\(showId)/seasons/\(season)/episodes/\(episodeNumber)", ["extended": "images,full"], .GET)
                case .Popular:
                    return ("shows/popular", ["extended":"images,full"], .GET)
            }
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        URLRequest.HTTPMethod = method.rawValue
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(URLRequest, parameters: parameters).0
    }
}

class TraktHTTPClient: NSObject {
    
    private lazy var manager: Alamofire.Manager = {
        let configuration: NSURLSessionConfiguration = {
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"]   = "gzip"
            headers["Content-Type"]      = "application/json"
            headers["trakt-api-version"] = "2"
            headers["trakt-api-key"]     = "19734df2d975560349c2d1b6bb9621bfdc2c2e3ef6023cbae7cfa71b938fbb79"
            //headers[""] =
            
            configuration.HTTPAdditionalHeaders = headers
            
            return configuration
        }()
        
        return Manager(configuration: configuration)
    }()
        
    func getShow(id: String, completion: ((Result<Show, NSError?>) -> Void)?) {
        getJSONElement(Router.Show(id), completion: completion)
    }
    
    func getEpisode(showId: String, season: Int, episodeNumber: Int, completion: ((Result<Episode, NSError?>) -> Void)?) {
        let router = Router.Episode(showId: showId, season: season,
            episodeNumber: episodeNumber)
        getJSONElement(router, completion: completion)
    }
    
    /*func getPopularShows(completion: ((Result<Array<Show>, NSError?>) -> Void)?) {
        // getJSONElement(Router.Popular, completion: completion)
        // getJSONArrayElement(Router.Popular, completion: completion)
    }*/
    
    func getPopularShows() -> Void {
        getJSONArrayElement(Router.Popular)
        
    }
    
    private func getJSONElement<T: Decodable where T.DecodedType == T>(router: Router, completion: ((Result<T, NSError?>) -> Void)?) {
        manager.request(router).validate().responseJSON { (_, _, responseObject, error) in
            if let json = responseObject as? NSDictionary {
        
                let decoded = T.decode(JSON.parse(json))
                
                if let value = decoded.value {
                    completion?(Result.success(value))
                } else {
                    completion?(Result.failure(nil))
                }
            } else {
                completion?(Result.failure(error))
            }
        }
    }
    
    private func getJSONArrayElement(router: Router) -> Void {
        manager.request(router).validate().responseJSON{(_, _, responseObject, error) in
        
            let json = responseObject as! Array<NSDictionary>
            //let decoded = JSON.parse(json)
            var result:Array<Show> = [Show]()
            //println(json.objectAtIndex(0))
            //println(decoded.description)
        
            for data in json {
                /*var title = JSON.parse(data["title"]!)
                var year = JSON.parse(data["year"]!)
                var ids = JSON.parse(data["ids"]!)*/
                
                let decoded = Show.decode(JSON.parse(data))
                let show = decoded.value
                
                result.append(show!)
            }
        
            println(result[0].title)
        
        
        
        }
    }
}
