//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Vatyx on 1/20/16.
//  Copyright © 2016 Vatyx. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let image : UIImage
        image = UIImage(named: "concrete_seamless.png")!
        let tintedImage = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        //self.view.backgroundColor = UIColor(red: CGFloat(202.0), green: CGFloat(228.0), blue: CGFloat(230.0), alpha: CGFloat(100.0))//UIColor(patternImage: image)
        //self.view.tintColor = UIColor(red: CGFloat(44), green: CGFloat(62), blue: CGFloat(80), alpha: CGFloat(80))
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            
                            self.movies = responseDictionary["results"] as! [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            print(movies.count)
            return Int(ceilf(Float(movies.count)/2.0))
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie1 = movies![indexPath.row * 2]
        let movie2 = movies![indexPath.row * 2 + 1]
        //let title = movie["title"] as! String
        //let overview = movie["overview"] as! String
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        let posterPath1 = movie1["poster_path"] as! String
        let posterPath2 = movie2["poster_path"] as! String
        
        let imageUrl1 = NSURL(string: baseUrl + posterPath1)
        let imageUrl2 = NSURL(string: baseUrl + posterPath2)
        
        //cell.titleLabel.text = title
        //cell.overviewLabel.text = overview
        cell.posterview1.setImageWithURL(imageUrl1!)
        if let imageUrl2 = imageUrl2 {
            cell.posterview2.setImageWithURL(imageUrl2)
        }
        
        print("row \(indexPath.row)")
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
