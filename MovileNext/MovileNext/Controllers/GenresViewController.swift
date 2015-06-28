//
//  GenresViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TagListView
import TraktModels

class GenresViewController: UIViewController, ShowInternalViewController {
    
    @IBOutlet weak var genresView: TagListView!
    var show:Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let genres = self.show?.genres {
            for genre in genres {
                self.genresView.addTag(genre)
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // Obtendo tamanho da TagListView
        println("Genres size: \(self.genresView.intrinsicContentSize().height)")
        var totalHeight = self.genresView.intrinsicContentSize().height + 39
        
        println("Genres total Height: \(totalHeight)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func intrinsicContentSize() -> CGSize {
        
        var totalHeight = self.genresView.intrinsicContentSize().height + 39
        
        return CGSize(width: self.view.frame.width, height: totalHeight)
    }
    
}
