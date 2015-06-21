//
//  ShowsViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import Alamofire
import Result
import TraktModels
import Argo

class ShowsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let traktAPI = TraktHTTPClient()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*// Testando API Trackt getShow
        traktAPI.getShow("game-of-thrones") { result in
            
            // Retorna um enum
            if let title = result.value?.title {
                println("Title: \(title)")
            }
        }
        
        // Testando API Trakt getEpisode
        traktAPI.getEpisode("game-of-thrones", season: 1, episodeNumber: 1) { (result) -> Void in
            if let overview = result.value?.overview {
                println("Overview: \(overview)")
            }
        }*/
        
        traktAPI.getPopularShows()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let indentifier = Reusable.ShowCell.identifier!
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(indentifier, forIndexPath: indexPath) as! ShowsCollectionViewCell
        
        cell.titleLabel.text = "Band of Brothers"
        
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
        //let newSpace = floor(((collectionView.bounds.width - usedSpace)) / 6)
        
        /*println("Used Space: \(usedSpace)| Item Size: \(itemSize) | Max Per Row: \(maxPerRow)")
        println("Border: \(border)| FlowLayoutInsetsLeft: \(flowLayout.sectionInset.left)")
        println("FlowLayoutInsetsRight: \(flowLayout.sectionInset.right)")
        println("Collection Width: \(collectionView.bounds.width) | Item Size: \(flowLayout.itemSize.width)")
        println("NewSpace: \(newSpace)")*/
        
        //return UIEdgeInsets(top: flowLayout.sectionInset.top, left: space, bottom: flowLayout.sectionInset.bottom, right: space)
        return UIEdgeInsets(top: newSpace, left: newSpace, bottom: newSpace, right: newSpace)
    }

}
