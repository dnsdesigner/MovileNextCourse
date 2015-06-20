//
//  MainViewController.swift
//  Exercicio2006
//
//  Created by User on 20/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import SafariServices

struct Entry {
    let title: String
    //let link: NSURL
    //let publishedDate: NSDate
    let link: NSURL
    let publishedDate: NSDate
    let contentSnippet: String
    let content: String
    
    init?(data: NSDictionary) {
        if let title = data["title"] as? String,
        let link = data["link"] as? String,
        let publishedDate = data["publishedDate"] as? String,
        let contentSnippet = data["contentSnippet"] as? String,
        let content = data["content"] as? String {
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss Z"
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            
            self.title = title
            self.link  = NSURL(string: link)!
            self.publishedDate  = formatter.dateFromString(publishedDate)!
            self.contentSnippet = contentSnippet
            self.content = content
            
        } else {
            
            return nil
            
        }
    }
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var jsonData:NSArray!
    var entriesArray = [Entry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Carregar dados JSON
        self.jsonData = self.fetchAllJsonData()
        
        // Carrego o array Entries
        for data in self.jsonData {
            
            var entry = Entry(data: data as! NSDictionary)
            if entry != nil {
                self.entriesArray.append(entry!)
            }
            
        }
        
        //println("Array Size: \(self.entriesArray.count)")
        
    }
    
    func fetchAllJsonData() -> [NSDictionary] {
        
        // Pega o caminho do arquivo json local
        let path = NSBundle.mainBundle().pathForResource("new-pods", ofType: "json")!
        
        // Pega o arquivo e transforma em NSData
        let jsonData = NSData(contentsOfFile: path)!
        
        // Fazer a serialização e transforma em NSDictionary
        let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as! NSDictionary
        
        if let jsonResponseData = jsonResult["responseData"] as? NSDictionary {
            if let jsonFeed = jsonResponseData["feed"] as? NSDictionary {
                if let jsonEntries = jsonFeed["entries"] as? [NSDictionary] {
                    return jsonEntries
                }
            }
        }
        
        return [NSDictionary]()
    }
    
    func textColor(date:NSDate) -> UIColor {
        
        var color:UIColor = UIColor.lightGrayColor()
        
        let formatter = NSDateFormatter()
        //formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss Z"
        formatter.dateFormat = "d MMM yyyy"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        let today = NSDate()
        let todayString = formatter.stringFromDate(today) as String
        let entrieDateString = formatter.stringFromDate(date) as String
        
        let todayDate: NSDate = formatter.dateFromString(todayString)!
        let entrieDate: NSDate = formatter.dateFromString(entrieDateString)!
        
        var dateComparisionResult: NSComparisonResult = todayDate.compare(entrieDate)
        
        /*// Date comparision to compare current date and end date.
        var dateComparisionResult:NSComparisonResult = today.compare(date)*/
        
        //println("Today: \(todayString) | Entrie: \(entrieDateString)")
        
        if dateComparisionResult == NSComparisonResult.OrderedAscending
        {
            // Current date is smaller than end date.
            // println("Current date is smaller")
        }
        else if dateComparisionResult == NSComparisonResult.OrderedDescending
        {
            // Current date is greater than end date.
            //println("Current date is greater")
            color = UIColor.lightGrayColor()
        }
        else if dateComparisionResult == NSComparisonResult.OrderedSame
        {
            // Current date and end date are same.
            //println("Current date are same")
            color = UIColor.blueColor()
        }
        
        return color
    }

    // MARK: - TableView DataSource and Delegates
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(identifier) as! MainTableViewCell
        
        var entrie = self.entriesArray[indexPath.row]
        
        cell.titleLabel.textColor = self.textColor(entrie.publishedDate)
        cell.contentSnippetLabel.textColor = self.textColor(entrie.publishedDate)
        
        cell.titleLabel.text = entrie.title
        cell.contentSnippetLabel.text = entrie.contentSnippet

        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var entrie = self.entriesArray[indexPath.row]
        
        //UIAlertView(title: entrie.title, message: entrie.publishedDate, delegate: self, cancelButtonTitle: "OK").show()
        
        UIApplication.sharedApplication().openURL(entrie.link)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let entrie = self.entriesArray[indexPath.row]
        
        var addToReadingList = UITableViewRowAction(style: .Normal, title: "Add to Reading List") { (action, indexPath) -> Void in
            tableView.editing = false
            println("Add to Reading List")
            
            var readList = SSReadingList.defaultReadingList()
            var status = readList.addReadingListItemWithURL(entrie.link, title: entrie.title, previewText: entrie.contentSnippet, error: nil)
            
            if status {
                println("Added URL Succesfully")
            } else {
                println("Failed to add URL")
            }
        }
        
        addToReadingList.backgroundColor = UIColor.blueColor()
        
        var addToFavorite = UITableViewRowAction(style: .Default, title: "Star") { (action, indexPath) -> Void in
            tableView.editing = false
            println("Add To Favorite List")
            
        }
        
        addToFavorite.backgroundColor = UIColor.orangeColor()
        
        return[addToFavorite, addToReadingList]
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            println("Delete touch")
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
            println("Insert touch")
        }
    }
    
}
