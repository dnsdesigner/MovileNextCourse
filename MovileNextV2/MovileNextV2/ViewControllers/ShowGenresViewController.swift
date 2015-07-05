//
//  ShowGenresViewController.swift
//  MovileNextV2
//
//  Created by Dennis de Oliveira on 03/07/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TagListView
import TraktModels

class ShowGenresViewController: UIViewController, ShowInternalViewController {
    
    @IBOutlet weak var genresTagListView: TagListView!
    var show:Show?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Carregar generos
        if let genres = self.show?.genres {
            for genre in genres {
                self.genresTagListView.addTag(genre)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
        println("\(self.dynamicType) deinit")
        
    }
    
    // MARK: - ShowInternalProtocol
    func intrinsicContentSize() -> CGSize {
        
        var totalHeight = self.genresTagListView.intrinsicContentSize().height + 39
        
        return CGSize(width: self.view.frame.width, height: totalHeight)
    }

}
