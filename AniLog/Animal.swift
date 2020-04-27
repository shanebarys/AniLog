//
//  Animal.swift
//  AniLog
//
//  Created by Shane Barys on 4/26/20.
//  Copyright © 2020 Shane Barys. All rights reserved.
//

import Foundation
import UIKit

class Animal {
    var type: String
    var name: String
    var description: String
    var rating: String
    var picture: UIImage
    var dateMet: String
    
    init(type: String, name: String, description: String, rating: String, picture: UIImage, dateMet: String) {
        self.name = name
        self.description = description
        self.type = type
        self.rating = rating
        self.picture = picture
        self.dateMet = dateMet
    }
}
