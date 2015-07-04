//
//  UserDefaultsManager.swift
//  NSUserDefaults
//
//  Created by Dennis de Oliveira on 28/06/15.
//  Copyright (c) 2015 Dennis de Oliveira. All rights reserved.
//

import UIKit

class FavoritesManager: NSObject {
    
    private var defaults = NSUserDefaults.standardUserDefaults()
    
    var favoritesIdentifiers: Set<Int> = {
        
        // Se existir retorna o objeto set com favoritos, senão retorna um objeto vazio
        if let favoritesId = NSUserDefaults.standardUserDefaults().objectForKey("favorites") as? [Int] {
            
            var favoritesSet:Set<Int> = Set(favoritesId)
            
            return favoritesSet

            
        } else {
            
            return Set<Int>()
            
        }
        
    }()
    
    func setFavorite(id: Int) {
        
        self.favoritesIdentifiers.insert(id)
        
        var array = Array(favoritesIdentifiers)
        
        self.defaults.setObject(array, forKey: "favorites")
        self.defaults.synchronize()
        
        println("Id \(id) adicionado a defaults")
        
    }
    
    func removeFavorite(id: Int) {
        
        self.favoritesIdentifiers.remove(id)
        
        var array = Array(favoritesIdentifiers)
        
        self.defaults.setObject(array, forKey: "favorites")
        self.defaults.synchronize()
        
        println("Id \(id) removido de defaults")
        
        
    }
    
}
