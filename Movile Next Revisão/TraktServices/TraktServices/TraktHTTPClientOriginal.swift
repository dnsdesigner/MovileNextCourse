//
//  TraktHTTPClientOriginal.swift
//  TraktServices
//
//  Created by Dennis de Oliveira on 22/06/15.
//  Copyright (c) 2015 Dennis de Oliveira. All rights reserved.
//
/*
import UIKit
import Alamofire
import Result
import Argo

private enum Router: URLRequestConvertible {
    
    // Variável que contém a url base para as requisições
    static let baseURLString = "https://api-v2launch.trakt.tv/"
    
    case Show(showId: String)
    case Episode(showId: String, season: Int, episodeNumber: Int)
    
    // Cria uma variável do tipo URL Request que é configurada com várias closures
    var URLRequest: NSURLRequest {
        
        // retorna uma tuple que será a url e parâmetros
        let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
            
            switch self {
            case .Show(let showId):
                return ("shows/\(showId)", ["extended": "images,full"], .GET)
            case .Episode(let showId, let season, let episodeNumber):
                return ("shows/\(showId)/seasons/\(season)/episodes/\(episodeNumber)", ["extended": "images,full"], .GET)
            }
            
            }()
        
        // Cria a url com base na tuple que foi criada e parametros do switch
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        URLRequest.HTTPMethod = method.rawValue
        let encoding = Alamofire.ParameterEncoding.URL
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
    
    // Função que irá passar uma string que é o slug/id do show e irá receber uma variável do tipo Result
    // Recebe como parametro o nome de uma variável que vai receber o Result e executar a closure
    func getShow(showId: String, completion: ((Result<Show, NSError?>) -> Void)?) {
        
        // Assinatura padrão do manager request
        /*manager.request(Router.Show(showId: showid)).validate().responseJSON(options: NSJSONReadingOptions.) { (NSURLRequest, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void in
        println("Resposta")
        }*/
        
        // Chamo a variável manager e chamo o método request passando Router.Show e o id do show para criar a url
        manager.request(Router.Show(showId: showId)).validate().responseJSON { (_, _, responseObject, error) -> Void in
            
            if let json = responseObject as? NSDictionary {
                
                let data = Show.decode(JSON.parse(json))
                
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
    
    func getEpisode(showId: String, season: Int, episodeNumber: Int,
        completion: ((Result<Episode, NSError?>) -> Void)?) {
            
            // Criar a requisição
            var route = Router.Episode(showId: showId, season: season, episodeNumber: episodeNumber)
            manager.request(route).validate().responseJSON { (_, _, responseObject, error) -> Void in
                
                if let json = responseObject as? NSDictionary {
                    
                    // Faz o parse com o Argo no model Episode
                    let data = Episode.decode(JSON.parse(json))
                    
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
    
}*/

