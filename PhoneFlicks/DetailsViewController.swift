//
//  DetailsViewController.swift
//  PhoneFlicks
//
//  Created by Terra Oldham on 9/4/17.
//  Copyright © 2017 HearsaySocial. All rights reserved.
//

import UIKit
import AFNetworking

class DetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet var detailView: UIView!
    @IBOutlet weak var detailTextView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var calendarImageView: UIImageView!
    
    var flick: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        let flickOverview = flick["overview"] as! String
        let flickTitle = flick["title"] as! String
        let flickPosterImage = flick["poster_path"] as! String
        let flickReleaseDate = flick["release_date"] as! String
        let flickRating = flick["vote_average"] as! Float
        let stringRating = String(format: "%.01f", flickRating)
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let imageUrl = URL(string: baseUrl + flickPosterImage)
        
        titleLabel.text = flickTitle
        overviewLabel.text = flickOverview
        releaseDateLabel.text = flickReleaseDate
        ratingLabel.text = stringRating
        posterView.setImageWith(imageUrl)
        
        
        overviewLabel.sizeToFit()
        titleLabel.bounds.size.width = overviewLabel.bounds.size.width
        titleView.center.x = overviewLabel.center.x
        ratingLabel.bounds.size.width = overviewLabel.bounds.size.width
        releaseDateLabel.bounds.size.width = overviewLabel.bounds.size.width
        
        
        let titleHeight = titleView.bounds.size.height
        let overviewHeight = overviewLabel.bounds.size.height
        let totalHeight = titleHeight + overviewHeight + 70.0
        let diffHeight = detailTextView.bounds.size.height - totalHeight
        
        detailTextView.center.y  += view.bounds.height
        UIView.animate(withDuration: 0.7, delay: 1.0, options: .curveEaseOut, animations: {
            self.detailTextView.center.y -= (self.view.bounds.height - diffHeight)
        }, completion: { finished in
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
