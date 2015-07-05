//
//  ShowSeasonViewController.swift
//  MovileNextV2
//
//  Created by Dennis de Oliveira on 03/07/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

protocol ShowSeasonViewControllerDelegate: class {
    func seasonsController(vc: ShowSeasonViewController, didSelectSeason season: Season)
}

class ShowSeasonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShowInternalViewController {

    @IBOutlet weak var tableView: UITableView!
    var showSeasons:[Season]?
    weak var delegate: ShowSeasonViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.scrollEnabled = false
        
        // Carregar dados
        loadSeasons(self.showSeasons)
    }
    
    deinit {
        
        println("\(self.dynamicType) deinit")
        
    }
    
    func loadSeasons(seasons: [Season]?) {
        self.showSeasons = seasons
        if isViewLoaded() {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let totalSeasons = self.showSeasons?.count {
            return totalSeasons
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.SeasonCell.identifier!
        let cell = self.tableView.dequeueReusableCellWithIdentifier(identifier) as! SeasonTableViewCell
        
        if let season = self.showSeasons?[indexPath.row] {
            cell.loadSeason(season)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let season = self.showSeasons?[indexPath.row] {
            self.delegate?.seasonsController(self, didSelectSeason: season)
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - ShowInternalProtocol
    func intrinsicContentSize() -> CGSize {
        
        var seasonsHeight = self.tableView.contentSize.height + 31
        //println("Seasons height: \(seasonsHeight)")
        
        return CGSize(width: self.view.frame.width, height: seasonsHeight)
        
    }

}
