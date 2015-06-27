//
//  ShowCollectionViewCell.swift
//  MovileNext
//
//  Created by Dennis de Oliveira on 25/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import Haneke

class ShowCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func loadShow(show: Show) {
        
        let placeholder = UIImage(named: "poster")
        
        /*if let url = show.poster?.mediumImageURL {
            self.posterImageView.hnk_setImageFromURL(url, placeholder: placeholder)
        } else {
            self.posterImageView.image = placeholder
        }*/
        
        self.posterImageView.image = placeholder
        self.titleLabel.text = show.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.hnk_cancelSetImage()
        posterImageView.image = nil
    }
}
