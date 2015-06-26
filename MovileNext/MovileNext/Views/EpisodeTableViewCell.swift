//
//  EpisodeTableViewCell.swift
//  MovileNext
//
//  Created by Dennis de Oliveira on 25/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Setando aparência do texto padrão
        textLabel?.textColor = UIColor.lightGrayColor()
        textLabel?.font = UIFont.systemFontOfSize(11)
        
        detailTextLabel?.textColor = UIColor.mup_textColor()
        detailTextLabel?.font = UIFont.systemFontOfSize(16)
    }
    
}
