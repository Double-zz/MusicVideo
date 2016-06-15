//
//  ViewController.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/3.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var videos = [Videos]()
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        #if swift(>= 2.2)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged),
                                                         name: "ReachStatusChanged", object: nil)
        //#else
           // NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged",
            //                                                 name: "ReachStatusChanged", object: nil)
        //#endif
        reachabilityStatusChanged()
        
        print(reachabilityStatus)
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }

    func didLoadData(videos: [Videos]) {
        
        for (index, item) in videos.enumerate() {
            
            print("\(index), the name is \(item.vName)")
            
        }
        
        
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


}

