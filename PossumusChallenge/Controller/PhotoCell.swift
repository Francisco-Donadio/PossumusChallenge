//
//  PhotoCell.swift
//  PossumusChallenge
//
//  Created by Francisco Donadio on 14/09/2022.
//

import Foundation
import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var imageTitle: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
