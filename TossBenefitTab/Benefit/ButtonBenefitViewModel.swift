//
//  ButtonBenefitViewModel.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/29.
//

import Foundation
import Combine

final class ButtonBenefitViewModel {
    @Published var benefit: Benefit
    @Published var benefitDetails: BenefitDetails?
    
    init(benefit: Benefit) {
        self.benefit = benefit
    }
    
    func fetchDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.benefitDetails = .default
        }
    }
}
