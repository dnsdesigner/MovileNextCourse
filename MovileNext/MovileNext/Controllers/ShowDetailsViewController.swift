//
//  ShowDetailsViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowDetailsViewController: UIViewController, SeasonsListViewControllerDelegate {
    
    private let httpClient = TraktHTTPClient()
    var show:Show?
    var showOverview: String?
    var showSeasons:[Season]?
    @IBOutlet weak var coverImageView: UIImageView!
    
    
    @IBOutlet weak var overviewConstraint: NSLayoutConstraint!
    @IBOutlet weak var seasonsConstraint: NSLayoutConstraint!
    
    private weak var overviewViewController: OverviewViewController!
    private weak var seasonListViewController: SeasonListViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Carregar dados
        self.loadData()
        
        // Atualizar imagem
        let placeholder = UIImage(named: "poster")
        
        if let url = self.show?.thumbImageURL {
            self.coverImageView.hnk_setImageFromURL(url, placeholder: placeholder)
        } else {
            self.coverImageView.image = placeholder
        }
        
        self.seasonListViewController.delegate = self
        
    }
    
    func loadData() {
        if let showIdentifier = self.show?.identifiers.slug {
            self.httpClient.getSeasons(showIdentifier, completion: { (result) -> Void in
                if let seasons = result.value {
                    println("Seasons carregada")
                    self.showSeasons = seasons
                    
                    self.seasonListViewController.loadSeasons(seasons)
                    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Colocar Constrain
        self.seasonsConstraint.constant = seasonListViewController.intrinsicContentSize().height + 20
        //self.overviewConstraint.constant = overviewViewController.overviewTextView.intrinsicContentSize().height + 39
        //println(overviewViewController.intrinsicContentSize().height)
        
    }
    

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueShowOverview" {
            
            let showOverview = segue.destinationViewController as! OverviewViewController
            if let overview = self.show?.overview {
                showOverview.overview = overview
            }
            
        } else if segue.identifier == "segueShowSeasons" {
            seasonListViewController = segue.destinationViewController as! SeasonListViewController
            seasonListViewController.loadSeasons(showSeasons)
        } else if segue.identifier == "segueShowGenres" {
            
            let showGenres = segue.destinationViewController as! GenresViewController
            showGenres.show = self.show
            
        } /*else if segue.identifier == "segueShowDetails" {
            let showDetails = segue.destinationViewController as! DetailsViewController
            showDetails.show = self.show
        }*/
        
    }
    
    // MARK: - SeasonListView
    func seasonsController(vc: SeasonListViewController, didSelectSeason season: Season) {
        println("Season: \(season.number)")
    }

}
