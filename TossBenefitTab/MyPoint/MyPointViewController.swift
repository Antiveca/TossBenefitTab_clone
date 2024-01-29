//
//  MyPointViewController.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/25.
//

import UIKit
import Combine

class MyPointViewController: UIViewController {
    
    @IBOutlet weak var pointLabel: UILabel!
    
    var myPointViewModel: MyPointViewModel!
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    private func setUI() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func bind() {
        myPointViewModel.$point
            .receive(on: RunLoop.main)
            .sink { point in
                self.pointLabel.text = "\(point.point)원"
            }.store(in: &subscriptions)
    }

}

