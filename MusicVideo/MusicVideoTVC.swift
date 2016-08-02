//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/20.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit
import LocalAuthentication

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
    var filterSearch = [Videos]()
    
    let resultSearchController = UISearchController(searchResultsController: nil)
    
    var limitCount = 10
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged),
                                                         name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.changedFontStyle), name:UIContentSizeCategoryDidChangeNotification , object: nil)
        //#endif
        reachabilityStatusChanged()
        touchIDChek()
        
           }
    
    func changedFontStyle() {
        
        print("UIFont style has changed")
    }
    
    func didLoadData(videos: [Videos]) {
        
        self.videos = videos
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        title = ("The iTunes Top \(limitCount) Music Videos")
  
        
        //setup the search controller
        
        resultSearchController.searchResultsUpdater = self
        
        definesPresentationContext = true
        
        resultSearchController.dimsBackgroundDuringPresentation = false
        
        //resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.
        
        resultSearchController.searchBar.placeholder = "Search for Artist or music name"
        
        // add the search bar to your tableView
        tableView.tableHeaderView = resultSearchController.searchBar
        
        tableView.reloadData()

        
    }
    
    func getAPICount() {
        
        if NSUserDefaults.standardUserDefaults().objectForKey("sliderValue") != nil {
            let apiCount = NSUserDefaults.standardUserDefaults().objectForKey("sliderValue") as! Int
            limitCount = apiCount
        }
        
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy.MM.dd G 'at' HH:mm:ss"
        let dateString = dateFormat.stringFromDate(NSDate())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(dateString)")
        
        
    }
    
    func runApi() {
        
        let api = APIManager()
        
        getAPICount()
        
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limitCount)/json", completion: didLoadData)
    }
    
    @IBAction func refreshVideos(sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        if resultSearchController.active {
           refreshControl?.attributedTitle = NSAttributedString(string: "Can not refresh in searcg")
        } else{
        runApi()
        }
    }
    
    
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
        case NOACCESS:
            //view.backgroundColor = UIColor.redColor()
            
            let alert = UIAlertController(title: "No Internet Access", message: "Please checking your internet connect", preferredStyle: .Alert )
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                action -> () in
                print("cancel")
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive ,
                                             handler: { test ->() in print("") } )
            
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: {test -> () in print("ok")})
            
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            alert.addAction(okAction)
            
            self.presentViewController(alert, animated: true , completion: nil)
            
        default:
            //view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("Do not refresh again")
            } else {
                runApi()
            }
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if resultSearchController.active {
            return filterSearch.count
        }
        return videos.count
    }
    
    private struct StoryboardID {
        static let cell = "cell"
        static let detailSegue = "detailView"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryboardID.cell, forIndexPath: indexPath) as! MusicVideoTableViewCell
        
        if resultSearchController.active {
            cell.video = filterSearch[indexPath.row]
        } else {
        cell.video = videos[indexPath.row]
        }
        return cell
    }
    
    //MARK: - Navigation
    //         Get the new view controller using segue.destinationViewController.
    //         Pass the selected object to the new view controller.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StoryboardID.detailSegue {
            
            if let index = tableView.indexPathForSelectedRow {
                
            let video: Videos
                
            if resultSearchController.active {
                video = filterSearch[index.row]
            } else {
                video = videos[index.row]
            }
            
            let detailView = segue.destinationViewController as! MusicVideoDetailVC
            detailView.videos = video
            }
        }
        
    }
 
    
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//         searchController.searchBar.text?.lowercaseString
//        filterVideo(searchController.searchBar.text!)
//        
//    }
    
    func filterVideo(searchText: String) {
//        let search1 = videos.filter { videos in
//            return videos.vArtist.lowercaseString.containsString(searchText.lowercaseString)
//        }
//        let search2 = videos.filter {videos in
//            return videos.vName.lowercaseString.containsString(searchText.lowercaseString)
//        }
//        let search3 = videos.filter {videos in
//            return String(videos.vrank).lowercaseString.containsString(searchText.lowercaseString)
//        }
//        filterSearch = search1 + search2 + search3
        filterSearch = videos.filter{ videos in
            return videos.vArtist.lowercaseString.containsString(searchText.lowercaseString) || videos.vName.lowercaseString.containsString(searchText.lowercaseString) || "\(videos.vrank)".lowercaseString.containsString(searchText.lowercaseString)}
        
        tableView.reloadData()
    }

    //check touchID in device
    func touchIDChek() {
        //print("checking touch ID")
        let content = LAContext()
        let defaults = NSUserDefaults.standardUserDefaults()

       if content.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: nil){
        
        defaults.setBool(true, forKey: "ToucnIDChecked")
       } else {
        defaults.setBool(false, forKey: "TouchIDChecked")
        }
        
        
    }
}
