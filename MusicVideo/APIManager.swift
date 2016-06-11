//
//  APIManager.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/3.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion: (result: String) -> Void ) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!
    
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil {
                
                dispatch_async(dispatch_get_main_queue()){
                    completion(result: error!.localizedDescription)
                }
                
            } else {
                
                // add JSON
                do {
                 
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary  {
                        print(json)
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(result: "JSONSerialization successful")
                            }
                        }
                    }
                 //the end of do
                } catch {
                    dispatch_async(dispatch_get_main_queue()){
                        completion(result: "error in JSONSerialization")
                    }
                }
            }
            
        }
        task.resume()   
        

        
        //the end of loadData
    }
    
    //the end of APIManager
}