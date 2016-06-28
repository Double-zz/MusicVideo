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
        
//        for (index, item) in videos.enumerate() {
//            
//            print("\(index), the name is \(item.vName)")
//            
//        }
//        
        tableView.reloadData()
        
    }
    
    func runApi() {
        let api = APIManager()
        
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: didLoadData)
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
   


}
