//
//  OverviewViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import FloatRatingView


class OverviewViewController: UIViewController {
    
    @IBOutlet weak var overviewTextView: UITextView!
    var overview:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Zerar espaçamento da textView
        overviewTextView.textContainer.lineFragmentPadding = 0
        overviewTextView.textContainerInset = UIEdgeInsetsZero
        
        self.overviewTextView.text = self.overview
        
    }
}
