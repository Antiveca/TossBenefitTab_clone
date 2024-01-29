//
//  BenefitListViewModel.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/29.
//

import Foundation
import Combine

final class BenefitListViewModel {
    @Published var todaySectionItems: [AnyHashable] = []
    @Published var otherSectionItems: [AnyHashable] = []

    let pointDidTapped = PassthroughSubject<MyPoint, Never>()
    let benefitDidTapped = PassthroughSubject<Benefit, Never>()
    
    func fetchItems() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //0.5초 딜레이로 받음(느린 네트워크 상황을 묘사)
            self.todaySectionItems = TodaySectionItem(point: .default, today: .today).sectionItems
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { //2.5초 딜레이로 받음(느린 네트워크 상황을 묘사)
            self.otherSectionItems = Benefit.others
        }
    }
}
