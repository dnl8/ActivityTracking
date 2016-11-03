//
//  AppState.swift
//  ActivityTrack
//
//  Created by Student on 03/11/16.
//  Copyright © 2016 Daniel Holzmann. All rights reserved.
//

import Foundation

class AppState: NSObject {
    
    static let sharedInstance = AppState()
    
    var signedIn = false
    var displayName: String?
}
