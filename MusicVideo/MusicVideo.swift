//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/11.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import Foundation

class Videos {
    
    private var _vName: String
    private var _vImageUrl: String
    private var _vVideoUrl: String
    
    var vName: String{
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    init(data: JSONDictionary) {
        
        if let name = data["im:name"] as? JSONDictionary,
            let viName = name["label"] as? String{
            self._vName = viName
        } else {
            _vName = ""
        }
        
        
        if let image = data["im:image"] as? JSONArray,
            let videoImage = image[3] as? String {
            
            _vImageUrl = videoImage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }else {
            _vImageUrl = ""
        }
        
        if let videoLink = data["link"] as? JSONArray,
        let attributes = videoLink[2] as? JSONDictionary,
            let herf = attributes["href"] as? String {
            self._vVideoUrl = herf
        } else {
            _vVideoUrl = ""
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}