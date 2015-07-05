//
//  ShowMoreViewController.swift
//  MovileNextV2
//
//  Created by Dennis de Oliveira on 03/07/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowMoreViewController: UIViewController {
    
    @IBOutlet weak var detailsTextView: UITextView!
    var show:Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Carregando qualquer coisa para testar
        //self.detailsTextView.text = self.show?.overview
        self.loadDetails()
    }
    
    deinit {
        
        println("\(self.dynamicType) deinit")
        
    }
    
    func loadDetails() {
        
        var showDetails:String = ""
        
        if let broadcasting = self.show?.network {
            showDetails += "Broadcasting: \(broadcasting)"
        }
        
        if let status:ShowStatus = self.show?.status {
            showDetails += "\nStatus: \(status.rawValue)"
        }
        
        if let startedIn = self.show?.firstAired {
            
            // Cria uma formatação de data para obter apenas o ano
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy"
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")

            let year = formatter.stringFromDate(startedIn) as String

            showDetails += "\nStarted in: \(year)"
        }
        
        if let country = self.show?.country {
            showDetails += "\nCountry: \(country.uppercaseString)"
        }

        self.detailsTextView.text = showDetails
    }
    
    // MARK: - ShowInternalProtocol
    func intrinsicContentSize() -> CGSize {
        
        var overviewHeight = self.detailsTextView.intrinsicContentSize().height + 39
        //println("Details height: \(overviewHeight)")
        
        return CGSize(width: self.view.frame.width, height: overviewHeight)
        
    }

}
