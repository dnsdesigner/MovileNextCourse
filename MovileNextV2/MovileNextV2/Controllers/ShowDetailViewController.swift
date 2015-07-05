//
//  ShowDetailViewController.swift
//  MovileNextV2
//
//  Created by Dennis de Oliveira on 03/07/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher
import FloatRatingView

class ShowDetailViewController: UIViewController, ShowSeasonViewControllerDelegate {
    
    private let httpClient = TraktHTTPClient()
    var show:Show?
    var season: Season?
    var showSeasons:[Season]?
    
    private var favoritesManager:FavoritesManager = FavoritesManager()
   
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    // ViewControllers
    private weak var showOverviewViewController: ShowOverviewViewController!
    private weak var showSeasonsViewController: ShowSeasonViewController!
    private weak var showGenresViewController: ShowGenresViewController!
    private weak var showMoreViewController: ShowMoreViewController!
    private weak var seasonEpisodesViewController: SeasonEpisodesViewController!
    
    // Constraints
    @IBOutlet weak var overviewConstraint: NSLayoutConstraint!
    @IBOutlet weak var seasonsConstraint: NSLayoutConstraint!
    @IBOutlet weak var genresConstraint: NSLayoutConstraint!
    @IBOutlet weak var moreConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Atualizar título da tela
        if let title = self.show?.title {
            self.title = title
        }
        
        if let showYear = self.show?.firstAired {
            
            // Cria uma formatação de data para obter apenas o ano
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy"
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            
            let year = formatter.stringFromDate(showYear) as String
            
            self.yearLabel.text  = year
        }
        
        // Carregar dados
        self.loadData()
        
        // Verificar favoritos
        self.isFavorite()
        
    }
    
    deinit {
        
        println("\(self.dynamicType) deinit")
        
    }
    
    func isFavorite() -> Bool {
        
        //println("Favoritos: \(self.favoritesManager.favoritesIdentifiers)")
        
        if let showId = self.show?.identifiers.slug {
            
            if FavoritesManager.favoritesIdentifiers.contains(showId) {
                
                self.favoriteButton.selected = true
                //println("Show existe em favoritos")
                
                return true
                
            } else {
                
                self.favoriteButton.selected = false
                //println("Show não existe em favoritos")
                
                return false
                
            }
            
        }
        
        return false
    }
    
    func loadData() {
        
        // Atualizar imagem
        let placeholder = UIImage(named: "bg")
        
        if let url = self.show?.thumbImageURL {
            self.coverImageView.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            self.coverImageView.image = placeholder
        }
        
        // Exibir Show Rating
        if let showRating = self.show?.rating {
            self.ratingView.rating = showRating
            self.ratingLabel.text = String(format: "%.1f", showRating)
        }
        
        if let showIdentifier = self.show?.identifiers.slug {
            
            self.httpClient.getSeasons(showIdentifier, completion: { (result) -> Void in
                if let seasons = result.value {
                    
                    println("Seasons carregada")
                    self.showSeasons = seasons
                    
                    self.showSeasonsViewController.loadSeasons(seasons)
                    
                } else {
                    
                    println("Oops \(result.error)")
                }
            })
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Atualiza a altura do container de acordo com a altura passada pelo view controller através do protocolo
        self.overviewConstraint.constant = self.showOverviewViewController.intrinsicContentSize().height
        self.seasonsConstraint.constant = self.showSeasonsViewController.intrinsicContentSize().height
        self.genresConstraint.constant = self.showGenresViewController.intrinsicContentSize().height
        self.moreConstraint.constant = self.showMoreViewController.intrinsicContentSize().height
        
    }

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Overview
        if segue.identifier == Segue.SegueShowOverview.identifier! {
            
            self.showOverviewViewController = segue.destinationViewController as! ShowOverviewViewController
            
            if let overview = self.show?.overview {
                self.showOverviewViewController.overview = overview
            }
            
        // Seasons
        } else if segue.identifier == Segue.SegueShowSeasons.identifier! {
            
            self.showSeasonsViewController = segue.destinationViewController as! ShowSeasonViewController
            self.showSeasonsViewController.delegate = self
            self.showSeasonsViewController.loadSeasons(showSeasons)
            
        // Genres
        } else if segue.identifier == Segue.SegueShowGenres.identifier! {
            
            self.showGenresViewController = segue.destinationViewController as! ShowGenresViewController
            self.showGenresViewController.show = self.show
        
        // More/Details
        } else if segue.identifier == Segue.SegueShowMore.identifier! {
            
            self.showMoreViewController = segue.destinationViewController as! ShowMoreViewController
            self.showMoreViewController.show = self.show
            
        // Season Episodes
        } else if segue.identifier == Segue.SegueSeasonEpisodes.identifier! {
            
            self.seasonEpisodesViewController = segue.destinationViewController as! SeasonEpisodesViewController
            self.seasonEpisodesViewController.season = self.season
            self.seasonEpisodesViewController.show = self.show
        }
        
    }
    
    // MARK: - ShowSeasons Delegate
    func seasonsController(vc: ShowSeasonViewController, didSelectSeason season: Season) {
        println("Season: \(season.number)")
        
        self.season = season
        performSegueWithIdentifier(Segue.SegueSeasonEpisodes.identifier!, sender: self)
    }
    
    // MARK: - Button Actions
    
    @IBAction func favoriteTouch(sender: AnyObject) {
        
        let button = sender as! UIButton
        
        
        // Cria uma animação
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        
        pulseAnimation.duration = 0.4
        pulseAnimation.fromValue = 1
        pulseAnimation.toValue = button.selected ? 1.2 : 0.8
        
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = 1
        
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        
        if let showId = self.show?.identifiers.slug {
            
            if self.isFavorite() {
                self.favoritesManager.removeFavorite(showId)
            } else {
                self.favoritesManager.setFavorite(showId)
            }
            
        }
        
        // Animação para exibir botão de favoritos
        UIView.transitionWithView(button, duration: 0.4, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            
            // Adiciona a animação criada no botão
            button.layer.addAnimation(pulseAnimation, forKey: nil)
            self.isFavorite()
            
        }, completion: nil)
        
        
    }
    
}
