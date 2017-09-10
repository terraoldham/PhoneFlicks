//
//  FlicksViewController.swift
//  PhoneFlicks
//
//  Created by Terra Oldham on 9/4/17.
//  Copyright © 2017 HearsaySocial. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class FlicksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var networkErrorView: UIView!


    
    var flicks: [NSDictionary]?
    var endpoint: String!
    var searchActive: Bool = false
    var filtered:[String] = []
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        getFlicksData()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let contentWidth = scrollView.bounds.width
        let contentHeight = scrollView.bounds.height * 3
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)

    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        let apiKey = "07a863aca7cc2d734ba6d085a5ec3006"
        let api_string = "https://api.themoviedb.org/3/movie/" + endpoint + "?api_key=\(apiKey)"
        print(api_string)
        let api_endpoint = URL(string: api_string)!
        let request = URLRequest(url: api_endpoint)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate:nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            MBProgressHUD.showAdded(to: self.view, animated: true)
            guard error == nil else {
                print("Error: Unable to call GET on /movies/now_playing/")
                self.networkErrorView.superview?.bringSubview(toFront: self.networkErrorView)
                self.networkErrorView.isHidden = false
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                guard let responseDictionary = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("Error: Unable to convert data to JSON")
                    return
                }
                print(responseDictionary)
                self.flicks = responseDictionary["results"] as? [NSDictionary]
                self.tableView.reloadData()
            } catch  {
                print("Error: Unable to convert data to JSON")
                return
            }
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            refreshControl.endRefreshing()
            
        }
        task.resume()
    }
    
    func getFlicksData() {
            let apiKey = "07a863aca7cc2d734ba6d085a5ec3006"
            let api_string = "https://api.themoviedb.org/3/movie/" + endpoint + "?api_key=\(apiKey)"
            let api_endpoint = URL(string: api_string)!
            let request = URLRequest(url: api_endpoint)
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate:nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
                MBProgressHUD.showAdded(to: self.view, animated: true)
                guard error == nil else {
                    print("Error: Unable to call GET on /movies/now_playing/")
                    self.networkErrorView.superview?.bringSubview(toFront: self.networkErrorView)
                    self.networkErrorView.isHidden = false
                    return
                }
                
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                
                do {
                    guard let responseDictionary = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                        print("Error: Unable to convert data to JSON")
                        return
                    }
                    print(responseDictionary)
                    self.flicks = responseDictionary["results"] as? [NSDictionary]
                    self.tableView.reloadData()
                } catch  {
                    print("Error: Unable to convert data to JSON")
                    return
                }
                MBProgressHUD.hide(for: self.view, animated: true)
                
            }
            task.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let flicks = flicks {
            return flicks.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "FlicksCell", for: indexPath) as! FlickCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = backgroundView
        
        let flick = flicks![indexPath.row]
        let title = flick["title"] as! String
        let overview = flick["overview"] as! String
        let posterPath = flick["poster_path"] as! String
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let imageUrl = URL(string: baseUrl + posterPath)
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.posterView.setImageWith(imageUrl)
        let imageRequest = NSURLRequest(url: NSURL(string: baseUrl + posterPath)! as URL)
        cell.posterView.setImageWith(imageRequest as URLRequest!, placeholderImage: nil, success: { (imageRequest, imageResponse, image) in
            if imageResponse != nil {
                print("Image was NOT cached, fade in image")
                cell.posterView.alpha = 0.0
                cell.posterView.image = image
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    cell.posterView.alpha = 1.0
                })
            } else {
                print("Image was cached so just update the image")
                cell.posterView.image = image
            }
        }) { (imageRequest, imageResponse, error) in
            print("There was a problem loading this")
        }
        
        return cell
    }
    
    
    let detailSegueIdentifier = "ShowDetailSegue"

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == detailSegueIdentifier,
            let destination = segue.destination as? DetailsViewController,
            let detailsIndex = tableView.indexPathForSelectedRow?.row
        {
            let detailFlick = flicks![detailsIndex]
            destination.flick = detailFlick

        }
    }
}
