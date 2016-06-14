//
//  ViewController.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/3.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(reachabilityStatus)
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }

    func didLoadData(videos: [Videos]) {
        
        for (index, item) in videos.enumerate() {
            
            print("\(index), the name is \(item.vName)")
            
        }
        
        
    }


}

