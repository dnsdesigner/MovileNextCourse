//
//  FavoritesManager.swift
//  MovileNext
//
//  Created by User on 28/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class FavoritesManager: NSObject {
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var favoritesIdentifiers: Set<Int> {
        
        if let favorites: AnyObject = defaults.objectForKey("favorites") {
            return favorites as! Set<Int>
        } else {
            return []
        }
        
    }
    
    func addIdentifier(identifier: Int) {
        
        self.defaults.setObject(identifier, forKey: "favorites")
        self.defaults.synchronize()
        
        println("Objeto adicionado com sucesso!")
        
        /*let defaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject("Palmeiras", forKey: "time")
        userDefaults.synchronize()
        let palmeiras = userDefaults.objectForKey("time")*/
        
    }
    
    func removeIdentifier(identifier: Int) {
        
    }
   
}
