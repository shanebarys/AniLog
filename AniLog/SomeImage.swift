//
//  SomeImage.swift
//  AniLog
//
//  Created by Shane Barys on 4/26/20.
//  Copyright © 2020 Shane Barys. All rights reserved.
//

import Foundation
import UIKit

//MAKIN UR PICS CODABLE HERE

public struct SomeImage: Codable {
    
    public let photo: Data
    
    public init(photo:  UIImage) {
        self.photo = photo.pngData() ?? Data()
    }
}
