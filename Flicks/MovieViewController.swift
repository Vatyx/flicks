import UIKit
import AFNetworking
import MBProgressHUD

class MovieViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    var movies: [NSDictionary]?
    
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UITextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataFromNetwork()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let currentIndex = defaults.integerForKey("currentIndex")
        print("Current index is \(currentIndex)")
        let currentMovie = defaults.objectForKey("currentMovie") as? NSDictionary
        
        self.title = (currentMovie!["title"] as! String)
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        let backdrop = currentMovie!["backdrop_path"] as! String
        let imageUrl = NSURL(string: baseUrl + backdrop)
        
        let title = currentMovie!["title"] as! String
        
        let score = currentMovie!["vote_average"] as! Double
        
        let date = currentMovie!["release_date"] as! String
        let splits = date.characters.split{$0 == "-"}.map(String.init)
        let actualDate = "\(splits[1])/\(splits[2])/\(splits[0])"
        
        let overview = currentMovie!["overview"] as! String

        backdropImage.setImageWithURL(imageUrl!)
        titleLabel.text = title
        scoreLabel.text = "\(score)/10"
        dateLabel.text = actualDate
        overviewLabel.text = overview
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = movies {
            print(movies.count)
            return 4
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let movie = movies![indexPath.row]
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        if let posterPath = movie["poster_path"] as? String {
            let imageUrl = NSURL(string: baseUrl + posterPath)
            cell.posterImage.setImageWithURL(imageUrl!)
        }
        
        print("row \(indexPath.row)")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        defaults.setInteger(indexPath.row, forKey: "currentIndex")
        defaults.setObject(self.movies![indexPath.row], forKey: "currentMovie")
        print("Selected cell number: \(indexPath.row)")
        
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("MovieViewController") as! MovieViewController
        self.navigationController!.pushViewController(next, animated:true)
    }

    
    func loadDataFromNetwork() {
        
        // Display HUD right before next request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        // ...
        
        let currentMovie = defaults.objectForKey("currentMovie") as? NSDictionary
        let id = currentMovie!["id"] as! Int
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(apiKey)")
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
                            self.collectionView.reloadData()
                    }
                }
                MBProgressHUD.hideHUDForView(self.view, animated: true)
        })
        
        task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from NSUserDefaults
        // and use it to update the tip amount
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
}
