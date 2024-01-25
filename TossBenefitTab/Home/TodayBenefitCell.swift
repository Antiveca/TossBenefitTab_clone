//
//  TodayBenefitCell.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/23.
//

import UIKit

class TodayBenefitCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.systemGray.withAlphaComponent(0.3)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
        actionButton.layer.masksToBounds = true
        actionButton.layer.cornerRadius = 5
    }
    
    
    func configure(item: Benefit) {
        titleLabel.text = item.title
        actionButton.setTitle(item.ctaTitle, for: .normal)
    }
}
