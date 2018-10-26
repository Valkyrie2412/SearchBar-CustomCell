//
//  Hero.swift
//  SearchBar
//
//  Created by Hiếu Nguyễn on 8/1/18.
//  Copyright © 2018 Hiếu Nguyễn. All rights reserved.
//

import UIKit

class Hero: Equatable {
    
    static func == (lhs: Hero, rhs: Hero) -> Bool {
        return lhs.name == rhs.name
    }
    
    
    var name: String
    var image: UIImage
    var category: String
    init(name: String, category: String, image: UIImage) {
        self.name = name
        self.category = category
        self.image = image
    }
}
enum HeroType: String {
    case agility = "Agility"
    case strength = "Strength"
}
