//
//  PhotoCell.swift
//  JJNote
//
//  Created by MAC on 2017-04-09.
//  Copyright © 2017 MAC. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btnMap: UIButton!
    
    var lat: Double = 0.0
    var lon: Double = 0.0
    
}
