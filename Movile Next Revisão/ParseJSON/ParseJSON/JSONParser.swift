//
//  JSONParser.swift
//  ParseJSON
//
//  Created by Dennis de Oliveira on 22/06/15.
//  Copyright (c) 2015 Dennis de Oliveira. All rights reserved.
//

import UIKit
import Argo

public struct JSONParser {
    
    public static func getAll() -> Array<Entry> {
        
        var entriesData = [Entry]()
        
        // Primeiro preciso pegar o caminho do arquivo dentro da minha aplicação
        if let path = NSBundle.mainBundle().pathForResource("new-pods", ofType: "json"),
            // Transformo esse arquivo em NSData para manipular e posteriormente Parsear
            let jsonData = NSData(contentsOfFile: path),
            // Faz a serialização do Json
            let jsonResult = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as? NSDictionary,
            let responseData = jsonResult["responseData"] as? NSDictionary,
            let feed = responseData["feed"] as? NSDictionary,
            let entries = feed["entries"] as? [NSDictionary] {
                
            for entry in entries {
                
                let decoded = Entry.decode(JSON.parse(entry))
                let data = decoded.value!
                entriesData.append(data)
                
            }
            
            return entriesData
                
        }
        
        // Retorn um array vazio para evitar crash
        return [Entry]()
    }
   
}
