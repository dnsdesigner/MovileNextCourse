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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func intrinsicContentSize() -> CGSize {
        return self.genresView.intrinsicContentSize()
    }
    
}
