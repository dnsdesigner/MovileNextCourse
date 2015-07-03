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
        
        // Calculo antigo de espaçamentos
        /*let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let border = flowLayout.sectionInset.left - flowLayout.sectionInset.right
        let itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let maxPerRow = floor((collectionView.bounds.width - border) / itemSize)
        let usedSpace = border + itemSize * maxPerRow
        let space = floor((collectionView.bounds.width - usedSpace) / 2)
        let newSpace = floor((collectionView.bounds.width - (flowLayout.itemSize.width * maxPerRow)) / 4)
        println("newSpace: \(newSpace)")
        return UIEdgeInsets(top: newSpace, left: newSpace, bottom: newSpace, right: newSpace)*/
        
        // Novo calulo para manter proporção
        
        // Crio a definição de espaço ideal entre os itens
        let idealSpace: CGFloat = 12
        
        // Cria uma variável para receber o flowlayout atual
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        // Zera os espaços existentes
        flowLayout.minimumInteritemSpacing = 0
        
        // Seto o espaço miníno entre linha
        flowLayout.minimumLineSpacing = idealSpace
        
        // Usa uma variável para armazanar a borda atual
        //let border = flowLayout.sectionInset.left - flowLayout.sectionInset.right
        //println("Section Inset Left: \(flowLayout.sectionInset.left) | Section Inset Right: \(flowLayout.sectionInset.right)")
        
        let itemWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        println("Item size width: \(flowLayout.itemSize.width) | Minimum item Spacing: \(flowLayout.minimumInteritemSpacing)")
        
        // Espaço disponível na tela
        let widthAvailable = collectionView.bounds.width
        
        let maxPerRow = 3 as CGFloat //floor(collectionView.bounds.width / itemWidth)
        println("Item size : \(itemWidth) | Collection size: \(collectionView.bounds.width) | Per row \(maxPerRow)")
        
        // Calcula o número de espaço entre itens e espaço usado entre eles
        let spaces = maxPerRow + 1
        let usedSpace = itemWidth * maxPerRow
        
        // Calcula o espaço necessário entre os itens
        let space = floor((collectionView.bounds.width - usedSpace) / spaces)
        
        println("Space: \(space)")
        
        let increaseWidth = floor((((space - idealSpace) * spaces) / maxPerRow))
        println("Increase Width: \(increaseWidth)")
        
        //flowLayout.itemSize = CGSizeMake(178, 160)
        //let novaLargura = ((space * spaces) - 18) / spaces
        
        let idealWidth = itemWidth + increaseWidth
        println("Ideal Width: \(idealWidth)")
        
        let idealHeight = round(((flowLayout.itemSize.height / itemWidth) * idealWidth))
        println("Ideal Height: \(idealHeight)")
        
        // Setar tamanho ideal
        flowLayout.itemSize = CGSizeMake(idealWidth, idealHeight)
        
        return UIEdgeInsets(top: space, left: space, bottom: space, right: space)
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
