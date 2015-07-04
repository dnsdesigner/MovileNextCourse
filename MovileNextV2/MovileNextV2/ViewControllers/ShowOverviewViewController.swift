//
//  ShowOverviewViewController.swift
//  MovileNextV2
//
//  Created by Dennis de Oliveira on 03/07/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class ShowOverviewViewController: UIViewController, ShowInternalViewController {
    
    @IBOutlet weak var overviewTextView: UITextView!
    var overview:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Zerar espaçamento da textView
        self.overviewTextView.textContainer.lineFragmentPadding = 0
        self.overviewTextView.textContainerInset = UIEdgeInsetsZero
        
        self.overviewTextView.text = overview
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ShowInternalProtocol
    func intrinsicContentSize() -> CGSize {
        
        var overviewHeight = self.overviewTextView.intrinsicContentSize().height + 39
        //println("Overview height: \(overviewHeight)")
        
        return CGSize(width: self.view.frame.width, height: overviewHeight)
        
    }

}
