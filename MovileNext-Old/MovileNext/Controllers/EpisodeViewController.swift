//
//  EpisodeViewController.swift
//  MovileNext
//
//  Created by User on 13/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBAction func sharePressed(sender: UIBarButtonItem) {
        
        if let url = NSURL(string: "http://www.apple.com") {
            
            let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            
            presentViewController(vc, animated: true, completion: nil)
        }
            
        println("pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.titleLabel.text = "Pilot"
        
        // Setando imagem
        //coverImageView.image = UIImage(named: "bg")
        
        // Remover margem do textview
        descriptionTextView.textContainer.lineFragmentPadding = 0
        descriptionTextView.textContainerInset = UIEdgeInsetsZero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
