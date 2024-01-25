//
//  buttonBenefitViewController.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/25.
//

import UIKit

class buttonBenefitViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    
    var benefit: Benefit = .today
    var benefitDetails: BenefitDetails = .default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        actionButton.layer.masksToBounds = true //true면 버튼레이어 밖으로는 그리지 않음(https://babbab2.tistory.com/47)
        actionButton.layer.cornerRadius = 5
        
        actionButton.setTitle(benefit.ctaTitle, for: .normal)
    }
    
}
