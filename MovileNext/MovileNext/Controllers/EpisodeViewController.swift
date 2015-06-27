//
//  EpisodeViewController.swift
//  MovileNext
//
//  Created by Dennis de Oliveira on 25/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Zerar espaçamento da textView
        overviewTextView.textContainer.lineFragmentPadding = 0
        overviewTextView.textContainerInset = UIEdgeInsetsZero
        
        // Escurecer imagem
        var placeHolder = UIImage(named: "bg")?.darkenImage()
        self.coverImageView.image = placeHolder
    }
    
    // MARK: Actions
    
    @IBAction func sharePressed(sender: UIBarButtonItem) {
        
        if let url = NSURL(string: "http://www.apple.com") {
            
            let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            
            presentViewController(vc, animated: true, completion: nil)
        }
        
        println("share pressed")
        
    }
}
