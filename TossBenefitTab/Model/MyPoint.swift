//
//  MyPoint.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/23.
//

import Foundation

struct MyPoint:Hashable {
    var point: Int
}

extension MyPoint {
    static let `default` = MyPoint(point: 0)
}
