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
import Kingfisher

class ShowCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func loadShow(show: Show) {
        
        let placeholder = UIImage(named: "poster")
        
        if let url = show.poster?.mediumImageURL {
            
            // Antigo componente de imagem Haneke
            //self.posterImageView.hnk_setImageFromURL(url, placeholder: placeholder)
            
            // Usando novo componente de imagem Kingfisher
            self.posterImageView.kf_setImageWithURL(url, placeholderImage: placeholder)
            
        } else {
            self.posterImageView.image = placeholder
        }
        
        //self.posterImageView.image = placeholder
        self.titleLabel.text = show.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //posterImageView.hnk_cancelSetImage()
        //let task = self.posterImageView.kf_setImageWithURL(NSURL(string: "http://your_image_url.png")!)
        //task.cancel()
       
        posterImageView.image = nil
    }
}
