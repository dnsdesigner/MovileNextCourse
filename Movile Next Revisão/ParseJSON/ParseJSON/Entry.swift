//
//  Entry.swift
//  ParseJSON
//
//  Created by Dennis de Oliveira on 22/06/15.
//  Copyright (c) 2015 Dennis de Oliveira. All rights reserved.
//

import Argo
import Runes
import ISO8601DateFormatter

public struct Entry {
    let title: String
    
    /*let link: NSURL
    let publishedDate: NSDate
    let contentSnippet: String
    let content: String*/
}

// Cria uma extensão de Entry usando protocolo Decodable
extension Entry:Decodable {
    
    static func create(title: String) -> Entry {
        return Entry(title: title)
    }
    
    public static func decode(json: JSON) -> Decoded<Entry> {
        return Entry.create
        <^> json <| "title"
    }
}