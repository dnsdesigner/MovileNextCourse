//
//  SeasonEpisodesViewController.swift
//  MovileNextV2
//
//  Created by User on 04/07/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import FloatRatingView
import TraktModels

class SeasonEpisodesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var season:Season?
    var show: Show?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Carregar dados
        self.loadData()
        
    }
    
    func loadData() {
        
        // Atualizar imagem
        let placeholderCover = UIImage(named: "bg")
        let placeholderPoster = UIImage(named: "poster")
        
        if let urlCover = self.season?.thumbImageURL {
            self.coverImageView.kf_setImageWithURL(urlCover, placeholderImage: placeholderCover)
        } else {
            if let urlShowCover = self.show?.thumbImageURL {
                self.coverImageView.kf_setImageWithURL(urlShowCover, placeholderImage: placeholderCover)
            }
        }
        
        if let urlPoster = self.season?.poster?.thumbImageURL {
            self.posterImageView.kf_setImageWithURL(urlPoster, placeholderImage: placeholderPoster)
        } else {
            self.posterImageView.image  = placeholderPoster
        }
        
        // Exibir Show Rating
        if let showRating = self.season?.rating {
            self.ratingView.rating = showRating
            self.ratingLabel.text = String(format: "%.1f", showRating)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.EpisodeCell.identifier!
        let cell = self.tableView.dequeueReusableCellWithIdentifier(identifier) as! UITableViewCell
        
        return cell
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
