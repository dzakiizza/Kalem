//
//  FirstLaunchManager.swift
//  KalemProject
//
//  Created by Dzaki Izza on 04/05/21.
//

import Foundation
class FirstLaunchManager {
    
static let shared = FirstLaunchManager()
var isFirstLaunch: Bool {
    get {
        UserDefaults.standard.bool(forKey: "firstLaunch")
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: "firstLaunch")
    }
}
}
