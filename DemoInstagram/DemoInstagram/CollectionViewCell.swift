//
//  CollectionViewCell.swift
//  DemoInstagram
//
//  Created by MacStudent on 2018-04-02.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imagePost: UIImageView!
    
    func setCellView(image:NSData){
        imagePost.image = UIImage(data:image as Data)
    }
}
