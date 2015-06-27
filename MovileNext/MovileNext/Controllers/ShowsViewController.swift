//
//  ShowsViewController.swift
//  MovileNext
//
//  Created by Dennis de Oliveira on 25/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let httpClient = TraktHTTPClient()
    private var shows: [Show]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Carregar os dados de shows
        self.loadShows()
        
    }
    
    func loadShows() {
        self.httpClient.getPopularShows { (result) -> Void in
            if let shows = result.value {
                println("Shows carregados com sucesso!")
                self.shows = shows
                self.collectionView.reloadData()
            } else {
                println("Oops \(result.error)")
            }
        }
    }
    
    // MARK: CollectionView Delegates
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let countShows = self.shows?.count {
            return countShows
        } else {
            return 0
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = Reusable.ShowCell.identifier!
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowCollectionViewCell
        
        if let show = self.shows?[indexPath.row] {
            //cell.titleLabel.text = show.title
            cell.loadShow(show)
        }
        
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let border = flowLayout.sectionInset.left - flowLayout.sectionInset.right
        let itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let maxPerRow = floor((collectionView.bounds.width - border) / itemSize)
        let usedSpace = border + itemSize * maxPerRow
        let space = floor((collectionView.bounds.width - usedSpace) / 2)
        let newSpace = floor((collectionView.bounds.width - (flowLayout.itemSize.width * maxPerRow)) / 4)
        
        return UIEdgeInsets(top: newSpace, left: newSpace, bottom: newSpace, right: newSpace)
    }
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = self.collectionView.indexPathForCell(cell)!
        
        if segue.identifier == "segueShowDetails" {
            
            let showDetails = segue.destinationViewController as! ShowDetailsViewController
            showDetails.show = self.shows?[indexPath.row]
            
            println(self.shows![indexPath.row].title)
            
        }
    }

}
