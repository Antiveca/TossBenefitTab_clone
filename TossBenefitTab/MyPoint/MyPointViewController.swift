//
//  MyPointViewController.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/25.
//

import UIKit

class MyPointViewController: UIViewController {
    
    @IBOutlet weak var pointLabel: UILabel!
    var point: MyPoint = .default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    

}

