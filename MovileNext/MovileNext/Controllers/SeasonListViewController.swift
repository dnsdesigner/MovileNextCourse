//
//  SeasonListViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

protocol SeasonsListViewControllerDelegate: class {
    func seasonsController(vc: SeasonListViewController, didSelectSeason season: Season)
}

class SeasonListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShowInternalViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var showsSeasons:[Season]?
    weak var delegate: SeasonsListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Listview carregada")
        loadSeasons(showsSeasons)
        
        // Desabilitar rolagem
        self.tableView.scrollEnabled = false
    }
    
    func loadSeasons(seasons: [Season]?) {
        self.showsSeasons = seasons
        if isViewLoaded() {
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Delegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let totalSeasons = self.showsSeasons?.count {
            return totalSeasons
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.SeasonCell.identifier!
        let cell =  self.tableView.dequeueReusableCellWithIdentifier(identifier) as! SeasonTableViewCell
        
        if let season = self.showsSeasons?[indexPath.row] {
            cell.loadSeason(season)
        }
        
        return cell
    }
    
    // MARK: ShowInternalProtocol
    func intrinsicContentSize() -> CGSize {
        return self.tableView.contentSize
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let season = self.showsSeasons?[indexPath.row] {
            self.delegate?.seasonsController(self, didSelectSeason: season)
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
