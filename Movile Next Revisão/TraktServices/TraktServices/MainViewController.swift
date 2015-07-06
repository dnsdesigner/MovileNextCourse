//
//  MainViewController.swift
//  TraktServices
//
//  Created by Dennis de Oliveira on 21/06/15.
//  Copyright (c) 2015 Dennis de Oliveira. All rights reserved.
//

import UIKit
import Result

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let traktRequest = TraktHTTPClient()
    var episodesDataSource = [Episode]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*// Testando Trakt HttpClient getShow
        self.traktRequest.getShow("game-of-thrones", completion: { (result) -> Void in
            println("Show title: \(result.value!.title)")
        })
        
        // Testando Trakt HttpClient getEpisode
        self.traktRequest.getEpisode("game-of-thrones", season: 1, episodeNumber: 1) { (result) -> Void in
            println("Show overview: \(result.value!.title)")
        }*/
        
        // Testando Trakt getPopularShows
        /*self.traktRequest.getPopularShows { (result) -> Void in
            var show = result.value![0] as Show
            println(show.title)
        }*/
        
        // Testando Trakt getSeasons
        /*self.traktRequest.getSeasons("game-of-thrones", completion: { (result) -> Void in
            var season = result.value![0] as Season
            println(result.value!.count)
        })*/
        
        // Testando getEpisodes
        self.traktRequest.getEpisodes("game-of-thrones", season: 1) { (result) -> Void in
            if let  episodes = result.value {
                
                self.episodesDataSource = episodes
                self.tableView.reloadData()
                
                for episode in episodes {
                    println("Episode: \(episode.title!)")
                }
            }
            
        }
    }
    
    // MARK: Table View Delegates and DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodesDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(identifier) as! UITableViewCell
        
        cell.textLabel?.text = self.episodesDataSource[indexPath.row].title
        cell.detailTextLabel?.text = self.episodesDataSource[indexPath.row].overview
        
        return cell
    }

}
