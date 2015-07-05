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
    
    static let favoritesChangedNotification = "favoritesChangedNotification"
    
    static var favoritesIdentifiers: Set<String> = {
        
        // Se existir retorna o objeto set com favoritos, senão retorna um objeto vazio
        if let favoritesId = NSUserDefaults.standardUserDefaults().objectForKey("favorites") as? [String] {
            
            var favoritesSet:Set<String> = Set(favoritesId)
            
            return favoritesSet
            
        } else {
            
            return Set<String>()
            
        }
        
    }()
    
    private func postNotification() {
        
        // Postar aviso de modificação no sistema
        let name = self.dynamicType.favoritesChangedNotification
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName(name, object: self)
        
    }
    
    func setFavorite(showId: String) {
        
        FavoritesManager.favoritesIdentifiers.insert(showId)
        
        var array = Array(FavoritesManager.favoritesIdentifiers)
        
        self.defaults.setObject(array, forKey: "favorites")
        self.defaults.synchronize()
        
        println("Id \(showId) adicionado a defaults")
        
        self.postNotification()
        
    }
    
    func removeFavorite(showId: String) {
        
        FavoritesManager.favoritesIdentifiers.remove(showId)
        
        var array = Array(FavoritesManager.favoritesIdentifiers)
        
        self.defaults.setObject(array, forKey: "favorites")
        self.defaults.synchronize()
        
        println("Id \(showId) removido de defaults")
        
        self.postNotification()
    }
    
}
