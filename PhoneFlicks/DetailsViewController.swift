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
    
    var flickTitle: String!
    var flickOverview: String!
    var flickPosterImage: String!
    var flickReleaseDate: String!
    var flickRating: Float!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = flickTitle
        overviewLabel.text = flickOverview
        ratingLabel.text = flickReleaseDate
        let stringRating = String(format: "%.01f", flickRating)
        releaseDateLabel.text = stringRating
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let imageUrl = URL(string: baseUrl + flickPosterImage)
        posterView.setImageWith(imageUrl)
        
        
        overviewLabel.sizeToFit()
        titleLabel.bounds.size.width = overviewLabel.bounds.size.width
        titleView.center.x = overviewLabel.center.x
        ratingLabel.bounds.size.width = overviewLabel
            .bounds.size.width / 2
        releaseDateLabel.bounds.size.width = overviewLabel.bounds.size.width / 2
        
        
        let titleHeight = titleView.bounds.size.height
        let overviewHeight = overviewLabel.bounds.size.height
        let totalHeight = titleHeight + overviewHeight + 25.0
        let diffHeight = detailTextView.bounds.size.height - totalHeight
        let fourthWidth = titleLabel.bounds.size.width / 4
        ratingLabel.center.x = titleLabel.center.x + fourthWidth
        releaseDateLabel.center.x = titleLabel.center.x - fourthWidth
        
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
