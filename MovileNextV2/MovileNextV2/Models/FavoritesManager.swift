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
    
    static var favoritesIdentifiers: Set<Int> = {
        
        // Se existir retorna o objeto set com favoritos, senão retorna um objeto vazio
        if let favoritesId = NSUserDefaults.standardUserDefaults().objectForKey("favorites") as? [Int] {
            
            var favoritesSet:Set<Int> = Set(favoritesId)
            
            return favoritesSet
            
        } else {
            
            return Set<Int>()
            
        }
        
    }()
    
    private func postNotification() {
        
        // Postar aviso de modificação no sistema
        let name = self.dynamicType.favoritesChangedNotification
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName(name, object: self)
        
    }
    
    func setFavorite(id: Int) {
        
        FavoritesManager.favoritesIdentifiers.insert(id)
        
        var array = Array(FavoritesManager.favoritesIdentifiers)
        
        self.defaults.setObject(array, forKey: "favorites")
        self.defaults.synchronize()
        
        println("Id \(id) adicionado a defaults")
        
        self.postNotification()
        
    }
    
    func removeFavorite(id: Int) {
        
        FavoritesManager.favoritesIdentifiers.remove(id)
        
        var array = Array(FavoritesManager.favoritesIdentifiers)
        
        self.defaults.setObject(array, forKey: "favorites")
        self.defaults.synchronize()
        
        println("Id \(id) removido de defaults")
        
        self.postNotification()
    }
    
}
