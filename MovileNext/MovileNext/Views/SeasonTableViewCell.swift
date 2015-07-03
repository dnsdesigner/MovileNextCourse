//
//  SeasonTableViewCell.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import FloatRatingView
import Haneke
import Kingfisher


class SeasonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadSeason(season: Season) {
        
        let placeholder = UIImage(named: "poster")
        
        if let url = season.poster?.thumbImageURL {
            //self.posterImageView.hnk_setImageFromURL(url, placeholder: placeholder)
            
            // Usando novo componente de imagem Kingfisher
            self.posterImageView.kf_setImageWithURL(url, placeholderImage: placeholder)
            
        } else {
            self.posterImageView.image = placeholder
        }
        
        self.titleLabel.text = "Season \(season.number)"
        self.episodesLabel.text = "\(season.episodeCount!) episodes"
        self.ratingView.rating = season.rating!
        self.ratingLabel.text = String(format: "%.1f", season.rating!)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //posterImageView.hnk_cancelSetImage()
        posterImageView.image = nil
    }

}
