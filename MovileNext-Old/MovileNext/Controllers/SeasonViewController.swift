//
//  SeasonViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class SeasonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let indentifier = Reusable.EpisodeCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(indentifier, forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = "S01E01 - S\(indexPath.section)R\(indexPath.row)"
        cell.detailTextLabel?.text = "Winter Is Coming"
        
        return cell
    }

}
