//
//  TraktHTTPClient.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import Alamofire

class TraktHTTPClient: NSObject {
    
    private lazy var manager: Alamofire.Manager = {
        let configuration: NSURLSessionConfiguration = {
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"] = "gzip"
            headers["Content-Type"]    = "application/json"
            headers["trakt-api-key"]   = "19734df2d975560349c2d1b6bb9621bfdc2c2e3ef6023cbae7cfa71b938fbb79"
            //headers[""] =
            
            configuration.HTTPAdditionalHeaders = headers
            
            return configuration
        }()
        
        return Manager(configuration: configuration)
    }()
   
}
