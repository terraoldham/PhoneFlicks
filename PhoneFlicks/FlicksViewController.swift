//
//  FlicksViewController.swift
//  PhoneFlicks
//
//  Created by Terra Oldham on 9/4/17.
//  Copyright © 2017 HearsaySocial. All rights reserved.
//

import UIKit

class FlicksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var flicks: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let apiKey = "07a863aca7cc2d734ba6d085a5ec3006"
        let now_playing_url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = URLRequest(url: now_playing_url!)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate:nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("Error: Unable to call GET on /movies/now_playing/")
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

        }
        task.resume()
        // Do any additional setup after loading the view.
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
        let cell = tableView .dequeueReusableCell(withIdentifier: "FlicksCell", for: indexPath)
        let flick = flicks![indexPath.row]
        let title = flick["title"] as! String
        cell.textLabel?.text = title
        print("row \(indexPath.row)")
        return cell
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
