//
//  CustomNavigationController.swift
//  MovileNext
//
//  Created by Dennis de Oliveira on 25/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    // Definindo o status bar para branco
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
