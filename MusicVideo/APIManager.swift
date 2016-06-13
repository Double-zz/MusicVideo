//
//  APIManager.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/3.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion: [Videos] -> Void ) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!
    
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                // add JSON
                do {
                 
                    
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                     //array = json["array"] as? JSONDictionary,
                     feed = json["feed"] as? JSONDictionary,
                     entry = feed["entry"] as? JSONArray {
                        
                        var videos = [Videos]()
                        for item in entry {
                          let videoData =  Videos(data: item as! JSONDictionary)
                            videos.append(videoData)
                        }
                        
                        let i = videos.count
                        print("total count \(i)")
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion( videos )
                            }
                        }
                    }
                 //the end of do
                } catch {
                         print("error in jsoinserialization")
                    
                }
            }
            
        }
        task.resume()   
        

        
        //the end of loadData
    }
    
    //the end of APIManager
}