//
//  MyPointViewModel.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/29.
//

import Foundation

final class MyPointViewModel {
    @Published var point: MyPoint

    init(point: MyPoint) {
        self.point = point
    }
}
