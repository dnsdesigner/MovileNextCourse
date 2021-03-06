//
//  ShowsViewController.swift
//  MovileNextV2
//
//  Created by Dennis de Oliveira on 03/07/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var page = 1
    let limit = 24
    var isLoading = false
    
    var loadingView = UIView()
    var loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    private var favoritesManager:FavoritesManager = FavoritesManager()
    private let httpClient = TraktHTTPClient()
    private var shows: [Show]?
    private var popularShows = [Show]()
    private var favoriteShows = [Show]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Carregar os shows
        self.loadShows()
        
        // Registrar notificação de favoritos
        let name = FavoritesManager.favoritesChangedNotification
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(self, selector: "favoritesChanged", name: name, object: nil)
        
        println(FavoritesManager.favoritesIdentifiers)
    }
    
    override func viewWillAppear(animated: Bool) {
        // Remover linha divisória
        self.navigationController?.navigationBar.hideBottomHairline()
        
        self.reloadShows()
    }
    
    override func viewWillDisappear(animated: Bool) {
        // Volta linha divisória
        self.navigationController?.navigationBar.showBottomHairline()
    }
    
    deinit {
        
        // Retirar o registro de notificação de favoritos
        let name = FavoritesManager.favoritesChangedNotification
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.removeObserver(self, name: name, object: nil)
        
        println("\(self.dynamicType) deinit")
        
    }
    
    func favoritesChanged() {
        
        println("Favorites changed executed!")
        
        self.favoriteShows.removeAll(keepCapacity: true)
        
        /*if let shows = self.shows {
            
            for show in shows {
            
                if FavoritesManager.favoritesIdentifiers.contains(show.identifiers.slug!) {
                    self.favoriteShows.append(show)
                }
            }
        }*/
        
        for showId in FavoritesManager.favoritesIdentifiers {
            println("slug: \(showId)")
            
            self.httpClient.getShow(showId, completion: { (result) -> Void in
                
                if let show = result.value {
                    self.favoriteShows.append(show)
                    println("Show \(show.identifiers.slug!) carregado com sucesso!")
                }
            })
        }
        
        self.reloadShows()
    }
    
    func loadingView(show: Bool) {
        
        self.loadingView.frame = self.view.frame
        self.loadingIndicator.frame = self.view.frame
        
        self.loadingView.backgroundColor = UIColor.whiteColor()
        self.loadingView.alpha = 0.9
        
        self.loadingIndicator.startAnimating()
        
        if show == true {
            
            self.loadingView.addSubview(self.loadingIndicator)
            self.view.addSubview(self.loadingView)
            
        } else {
                
            self.loadingView.removeFromSuperview()
            self.loadingIndicator.removeFromSuperview()
            
        }
        
    }
    
    
    func loadShows() {
        
        if self.isLoading == false {
            
            // Exibe a view com o loading
            self.loadingView(true)
            
            // Aviso que existe uma requisição em andamento
            self.isLoading = true
        
            self.httpClient.getPopularShows(1, limit: limit) { (result) -> Void in
                if let shows = result.value {
                    println("Shows carregados com sucesso!")
                    
                    self.popularShows = shows
                    
                    
                    // Carrega os favoritos
                    /*for show in shows {
                        
                        if FavoritesManager.favoritesIdentifiers.contains(show.identifiers.trakt) {
                            self.favoriteShows.append(show)
                        }
                        
                    }*/
                    
                    for showId in FavoritesManager.favoritesIdentifiers {
                        println("slug: \(showId)")
                        
                        self.httpClient.getShow(showId, completion: { (result) -> Void in
                            
                            if let show = result.value {
                                self.favoriteShows.append(show)
                                println("Show \(show.identifiers.slug) carregado com sucesso!")
                            }
                        })
                    }
                    
                    self.reloadShows()
                    self.isLoading = false
                    
                    // Remove a view com loading
                    self.loadingView(false)
                    
                } else {
                    println("Oops \(result.error)")
                }
            }
        }
        
    }
    
    func loadMore() {
        
        if self.isLoading == false {
            
            // Exibe a view com o loading
            self.loadingView(true)
            
            // Aviso que existe uma requisição em andamento
            self.isLoading = true
            
            self.page += 1
            
            self.httpClient.getPopularShows(self.page, limit: self.limit, completion: { (result) -> Void in
                
                if let shows = result.value {
                    println("Página \(self.page) de Shows carregada com sucesso!")
                    
                    for show in shows {
                        self.popularShows.append(show)
                        
                        // Verifica favoritos
                        /*if FavoritesManager.favoritesIdentifiers.contains(show.identifiers.trakt) {
                            self.favoriteShows.append(show)
                        }*/
                    }
                    
                    self.reloadShows()
                    self.isLoading = false
                    
                    // Remove a view com loading
                    self.loadingView(false)
                    
                } else {
                    println("Oops \(result.error)")
                }
                
            })
            
        }
        
    }
    
    func reloadShows() {
        
        switch self.filterSegmentedControl.selectedSegmentIndex {
            case 0:
                self.shows = self.popularShows
                self.collectionView.reloadData()
            case 1:
                self.shows = self.favoriteShows
                self.collectionView.reloadData()
            default:
                self.collectionView.reloadData()
        }
    }
    
    
    // MARK: - CollectionView
    
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
            cell.loadShow(show)
        }
        
        if indexPath.row == self.popularShows.count - 3 {
            self.loadMore()
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        // Novo calulo para manter proporção entre as celulas
        
        // Crio a definição de espaço ideal entre os itens
        let idealSpace: CGFloat = 12
        
        // Cria uma variável para receber o flowlayout atual
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        // Zera os espaços existentes
        flowLayout.minimumInteritemSpacing = 0
        
        // Seto o espaço miníno entre linha
        flowLayout.minimumLineSpacing = idealSpace
        
        let itemWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        
        // Espaço disponível na tela
        let widthAvailable = collectionView.bounds.width
        
        let maxPerRow:CGFloat = 3
        
        // Calcula o número de espaço entre itens e espaço usado entre eles
        let spaces = maxPerRow + 1
        let usedSpace = itemWidth * maxPerRow
        
        // Calcula o espaço necessário entre os itens
        let space = floor((collectionView.bounds.width - usedSpace) / spaces)
        
        let increaseWidth = floor((((space - idealSpace) * spaces) / maxPerRow))
        
        let idealWidth = itemWidth + increaseWidth
        
        let idealHeight = round(((flowLayout.itemSize.height / itemWidth) * idealWidth))
        
        // Setar tamanho ideal
        flowLayout.itemSize = CGSizeMake(idealWidth, idealHeight)
        
        return UIEdgeInsets(top: space, left: space, bottom: space, right: space)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = self.collectionView.indexPathForCell(cell)!
        
        if segue.identifier == Segue.SegueShowDetail.identifier {
            
            let showDetail = segue.destinationViewController as! ShowDetailViewController
            showDetail.show = self.shows?[indexPath.row]
            
            println(self.shows![indexPath.row].title)
            
        }
    }
    
    // MARK: - Segmented Control
    
    @IBAction func SegmentedTouch(sender: AnyObject) {
     
        //println("Segmented index: \(self.filterSegmentedControl.selectedSegmentIndex)")
        self.reloadShows()
        
    }
    

}
