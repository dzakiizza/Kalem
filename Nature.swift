//
//  Nature.swift
//  KalemProject
//
//  Created by Dzaki Izza on 30/04/21.
//

import Foundation
import UIKit

struct Nature {
    
    var name : String
    var image : String
    var soundOfNature : String
    var desc : String
    

    init(naturesName : String, naturesImage : String, naturesSound : String, natureDesc : String) {
        
        name = naturesName
        image = naturesImage
        soundOfNature = naturesSound
        desc = natureDesc
        
    }
}

