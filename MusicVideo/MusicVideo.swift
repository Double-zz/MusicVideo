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
    private var _vRights: String
    private var _vPrice: String
    private var _vArtist: String
    private var _vImid: String
    private var _vgenre: String
    private var _vLinkToiTunes: String
    private var _vReleaseDate: String
    
    var vrank = 0
    
    
    var vImageData: NSData?
    
    var vName: String{
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
     
    var vArtist: String {
        return _vArtist
    }
    
    var vImid: String {
        return _vImid
    }
    
    var vGenre: String {
        return _vgenre
    }
    
    var vLinkToiTunes : String {
        return _vLinkToiTunes
    }
    
    var vReleaseDate: String {
        return _vReleaseDate
    }
    
    
    
    
    init(data: JSONDictionary) {
        
        if let name = data["im:name"] as? JSONDictionary,
            let viName = name["label"] as? String{
            self._vName = viName
        } else {
            _vName = ""
        }
        
        
        if let image = data["im:image"] as? JSONArray,
            let videoImage = image[2] as? JSONDictionary,
        let imageLabel = videoImage["label"] as? String{
            self._vImageUrl = imageLabel
            // change image size for performance
        }else {
            _vImageUrl = ""
        }
        
        if let videoLink = data["link"] as? JSONArray,
        let attributes = videoLink[1] as? JSONDictionary,
            let sattributes = attributes["attributes"]  as? JSONDictionary,
            let herf = sattributes["href"] as? String {
            self._vVideoUrl = herf
        } else {
            _vVideoUrl = ""
        }
        
        if let rights = data["rights"] as? JSONDictionary,
            let vRights = rights["label"] as? String {
            self._vRights = vRights
        } else {
            _vRights = ""
        }
        
        if let price = data["im:price"] as? JSONDictionary,
            let vPrice = price["label"] as? String {
            self._vPrice = vPrice
        } else {
            _vPrice = ""
        }
        
        if let artist = data["im:artist"] as? JSONDictionary,
            let imArtist = artist["label"] as? String {
            self._vArtist = imArtist
        } else {
            _vArtist = ""
        }
        
        if let imid = data["id"] as? JSONDictionary,
        let attributes = imid["attributes"] as? JSONDictionary,
            let attId = attributes["im:id"] as? String {
            self._vImid = attId
        } else {
            _vImid = ""
        }
        
        if let genre = data["category"] as? JSONDictionary,
        let attributesGenre = genre["attributes"] as? JSONDictionary,
            let videoGenre = attributesGenre["term"] as? String {
            self._vgenre = videoGenre
        } else {
            _vgenre = ""
        }
        
        if let toiTunes = data["link"] as? JSONArray,
            let theDictionary = toiTunes[0] as? JSONDictionary,
        let theSDic = theDictionary["attributes"] as? JSONDictionary,
        let theLink = theSDic["href"]as? String{
            self._vLinkToiTunes = theLink
        } else {
            _vLinkToiTunes = ""
        }
        
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary,
            let theDate = releaseDate["label"] as? String {
            self._vReleaseDate = theDate
        } else {
            _vReleaseDate = ""
        }
        
        
    // end of init
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}