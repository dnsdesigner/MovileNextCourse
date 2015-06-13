//
//  AppDelegate.swift
//  MovileNext
//
//  Created by User on 6/13/15
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        // Setando cor de fundo da barra para laranja
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = UIColor.mup_orangeColor()
        
        // Setando cor do texto e tint color para branco
        let attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        appearance.titleTextAttributes = attrs
        appearance.tintColor = UIColor.whiteColor()
        
        return true
    }
}
