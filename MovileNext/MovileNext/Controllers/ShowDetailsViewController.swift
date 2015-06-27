//
//  ShowDetailsViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowDetailsViewController: UIViewController {
    
    private let httpClient = TraktHTTPClient()
    var show:Show?
    var showOverview: String?
    var showSeasons:[Season]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Carregar dados
        self.loadData()
        
        println(self.show?.genres)
        
    }
    
    func loadData() {
        if let showIdentifier = self.show?.identifiers.slug {
            self.httpClient.getSeasons(showIdentifier, completion: { (result) -> Void in
                if let seasons = result.value {
                    self.showSeasons = seasons
                    println(self.showSeasons?.count)
                } else {
                    println("Oops \(result.error)")
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueShowSeasons" {
            let seasonsView = segue.destinationViewController as! SeasonListViewController
            seasonsView.showsSeasons = self.showSeasons
        } else if segue.identifier == "segueShowOverview" {
            
            let showOverview = segue.destinationViewController as! OverviewViewController
            if let overview = self.show?.overview {
                showOverview.overview = overview
            }
            
        } else if segue.identifier == "segueShowGenres" {
            
            let showGenres = segue.destinationViewController as! GenresViewController
            showGenres.show = self.show
            
        } else if segue.identifier == "segueShowDetails" {
            let showDetails = segue.destinationViewController as! DetailsViewController
            showDetails.show = self.show
        }
        
    }

}
