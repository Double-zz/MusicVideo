//
//  ViewController.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/3.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var videos = [Videos]()
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged),
                                                         name: "ReachStatusChanged", object: nil)
                //#endif
        reachabilityStatusChanged()
        
        print(reachabilityStatus)
        
        let api = APIManager()
        
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
    }

    func didLoadData(videos: [Videos]) {
    
        self.videos = videos
        
        for (index, item) in videos.enumerate() {
            
            print("\(index), the name is \(item.vName)")
            
        }
        
        tableView.reloadData()

    }
    
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
        case NOACCESS: view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI: view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable with WIFI"
        case WWAN: view.backgroundColor = UIColor.blueColor()
            displayLabel.text = "Reachable with Cellular"
        default:return
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row + 1)"
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }
    
    
 
    
}

