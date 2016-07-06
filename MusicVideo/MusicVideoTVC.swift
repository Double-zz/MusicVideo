//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/20.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    var limitCount = 10
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged),
                                                         name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.changedFontStyle), name:UIContentSizeCategoryDidChangeNotification , object: nil)
        //#endif
        reachabilityStatusChanged()
        
        
           }
    
    func changedFontStyle() {
        
        print("UIFont style has changed")
    }
    
    func didLoadData(videos: [Videos]) {
        
        self.videos = videos
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        title = ("The iTunes Top \(limitCount) Music Videos")
  
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
        runApi()
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
        return videos.count
    }
    
    private struct StoryboardID {
        static let cell = "cell"
        static let detailSegue = "detailView"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryboardID.cell, forIndexPath: indexPath) as! MusicVideoTableViewCell

        cell.video = videos[indexPath.row]
        
        return cell
    }
    
    //MARK: - Navigation
    //         Get the new view controller using segue.destinationViewController.
    //         Pass the selected object to the new view controller.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StoryboardID.detailSegue {
            let index = tableView.indexPathForSelectedRow
            let video = videos[(index?.row)!]
            let detailView = segue.destinationViewController as! MusicVideoDetailVC
            detailView.videos = video
        }
        
    }
 
    
   


}
