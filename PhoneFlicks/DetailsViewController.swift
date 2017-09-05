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
    
    var flickTitle: String!
    var flickOverview: String!
    var flickPosterImage: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = flickTitle
        overviewLabel.text = flickOverview
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let imageUrl = URL(string: baseUrl + flickPosterImage)
        posterView.setImageWith(imageUrl)
        detailTextView.center.y  += view.bounds.height
        UIView.animate(withDuration: 0.7, delay: 1.0, options: .curveEaseOut, animations: {
            self.detailTextView.center.y -= self.view.bounds.height
        }, completion: { finished in
            print("Animation success")
        })
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
