//
//  BenefitGuideView.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/26.
//

import UIKit

//코드로 UI 구현
final class BenefitGuideView: UIView {
    lazy var icon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(icon) //이미지 그리기
        addSubview(title) //레이블 그리기
        
        NSLayoutConstraint.activate([ //오토레이아웃
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 30), //이미지 넓이
            icon.heightAnchor.constraint(equalToConstant: 30), //이미지 높이
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20), //아이콘 이미지와의 간격 20
            title.centerYAnchor.constraint(equalTo: icon.centerYAnchor)

        ])
    }
}
