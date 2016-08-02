//
//  File.swift
//  MusicVideo
//
//  Created by Veronica on 16/8/2.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit

extension MusicVideoTVC: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.searchBar.text?.lowercaseString
        filterVideo(searchController.searchBar.text!)
        
    }
    
}
