//
//  BenefitCell.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/23.
//

import UIKit

class BenefitCell: UICollectionViewCell {
    
    @IBOutlet weak var benefitIconImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(item: Benefit) {
        benefitIconImage.image = UIImage(named: item.imageName)
        descriptionLabel.text = item.title
        titleLabel.text = item.title
    }
}
