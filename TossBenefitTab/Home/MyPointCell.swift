//
//  MyPointCell.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/23.
//

import UIKit

class MyPointCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    func configure(item: MyPoint) {
        iconImage.image = UIImage(named: "ic_point")
        descriptionLabel.text = "내 포인트"
        pointLabel.text = "\(item.point)원"
    }
}
