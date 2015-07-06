//
//  MainViewController.swift
//  ParseJSON
//
//  Created by Dennis de Oliveira on 23/06/15.
//  Copyright (c) 2015 Dennis de Oliveira. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let entries = JSONParser.getAll()
    let activityIndicator = UIActivityIndicatorView()
    let bgView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.frame = self.view.frame
        bgView.backgroundColor = UIColor.whiteColor()
        bgView.alpha = 0.8
        
        bgView.addSubview(activityIndicator)
        
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        activityIndicator.startAnimating()
        
        self.view.addSubview(bgView)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.bgView.removeFromSuperview()
    }
    
    // MARK: Table View Delegates and DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "Cell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(identifier) as! UITableViewCell
        
        let entry = self.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}