//
//  TraktHTTPClient.swift
//  MovileNext
//
//  Created by Dennis de Oliveira on 25/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import Alamofire
import Result
import Argo
import TraktModels


private enum Router: URLRequestConvertible {
    
    static let baseURLString = "https://api-v2launch.trakt.tv/"
    
    case Show(showId: String)
    case Episode(showId: String, season: Int, episodeNumber: Int)
    case Episodes(showId: String, season: Int)
    case Popular
    case Seasons(showId: String)
    
    // Constant closure
    var URLRequest: NSURLRequest {
        
        // Cria uma tupla
        let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
            
            switch self {
            case .Show(let showId):
                return ("shows/\(showId)", ["extended": "images,full"], .GET)
            case .Episode(let showId, let season, let episodeNumber):
                return ("shows/\(showId)/seasons/\(season)/episodes/\(episodeNumber)", ["extended": "images,full"], .GET)
            case .Episodes(let showId, let season):
                return ("shows/\(showId)/seasons/\(season)",["extended" : "images, full, episodes"], .GET)
            case .Popular:
                return ("shows/popular", ["extended": "images,full"], .GET)
            case .Seasons(let showId):
                return ("shows/\(showId)/seasons", ["extended" : "images, full"], .GET)
            }
            
            }()
        
        // Cria uma URLRequest com base na escolha da Router, e tuple passada
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        URLRequest.HTTPMethod = method.rawValue
        let encoding = Alamofire.ParameterEncoding.URL
        
        // Retorna o valor no indice 0, que é o indice de valor
        return encoding.encode(URLRequest, parameters: parameters).0
    }
}

class TraktHTTPClient: NSObject {
    
    // Manager é uma variável privada que recebe como valor o retorno de uma closure
    private lazy var manager: Alamofire.Manager = {
        
        // configuration é uma variável dentro da closure manager e recebe o retorno de outra closure
        let configuration: NSURLSessionConfiguration = {
            
            // Na closure da configuration são configurados os parametros de headers
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"]   = "gzip"
            headers["Content-Type"]      = "application/json"
            headers["trakt-api-version"] = "2"
            headers["trakt-api-key"]     = "19734df2d975560349c2d1b6bb9621bfdc2c2e3ef6023cbae7cfa71b938fbb79"
            
            // Adiciono as Headers adicionais da requisição
            configuration.HTTPAdditionalHeaders = headers
            return configuration
            
            }()
        
        return Alamofire.Manager(configuration: configuration)
        
        }()
    
    // Função para deixar códigos de requisição menos repetitivos usando generics
    private func getJSONElement<T: Decodable where T.DecodedType == T>(router: Router, completion: ((Result<T, NSError?>) -> Void)?) {
        
        manager.request(router).validate().responseJSON { (_, _, responseObject, error) -> Void in
            
            if let json = responseObject as? NSDictionary {
                
                let data = T.decode(JSON.parse(json))
                
                if let value = data.value {
                    completion?(Result.success(value))
                } else {
                    completion?(Result.failure(nil))
                }
            } else {
                completion?(Result.failure(error))
            }
        }
        
    }
    
    private func getJSONElements<T: Decodable where T.DecodedType == T>(router: Router, completion: ((Result<Array<T>, NSError?>) -> Void)?) {
        
        var resultData: Array<T> = [T]()
        
        manager.request(router).validate().responseJSON { (_, _, responseObject, error) -> Void in
            
            if let json = responseObject as? Array<NSDictionary> {
                
                // Percorro o array e adiciono no array allData
                for data in json {
                    
                    var data = T.decode(JSON.parse(data))
                    
                    if let value = data.value {
                        
                        resultData.append(value)
                        
                    }
                }
                
                completion?(Result.success(resultData))
                
            } else {
                completion?(Result.failure(error))
            }
        }
        
    }
    
    func getShow(showId: String, completion: ((Result<Show, NSError?>) -> Void)?) {
        
        // Código simplificado com uso de Generics
        getJSONElement(Router.Show(showId: showId), completion: completion)
        
    }
    
    func getEpisode(showId: String, season: Int, episodeNumber: Int, completion: ((Result<Episode, NSError?>) -> Void)?) {
        
        getJSONElement(Router.Episode(showId: showId, season: season, episodeNumber: episodeNumber), completion: completion)
        
    }
    
    func getPopularShows(completion:((Result<Array<Show>, NSError?>) -> Void)?) {
        
        getJSONElements(Router.Popular, completion: completion)
        
    }
    
    func getSeasons(showId: String, completion: ((Result<Array<Season>, NSError?>) -> Void)?) {
        
        getJSONElements(Router.Seasons(showId: showId), completion: completion)
        
    }
    
    func getEpisodes(showId: String, season: Int, completion: ((Result<Array<Episode>, NSError?>) -> Void)?) {
        
        getJSONElements(Router.Episodes(showId: showId, season: season), completion: completion)
        
    }
    
    
    
}
