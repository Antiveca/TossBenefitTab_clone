//
//  buttonBenefitViewController.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/25.
//

import UIKit

class ButtonBenefitViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var verticalStackView: UIStackView!
    var benefit: Benefit = .today
    var benefitDetails: BenefitDetails = .default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addGuides()
        
        actionButton.setTitle(benefit.ctaTitle, for: .normal)
    }
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        actionButton.layer.masksToBounds = true //true면 버튼레이어 밖으로는 그리지 않음(https://babbab2.tistory.com/47)
        actionButton.layer.cornerRadius = 5
    }
    
    private func addGuides() {
        let guideViews: [BenefitGuideView] = benefitDetails.guides.map { guide in //benefitDetails.guides배열의 딕셔너리 값을 하나씩 받음
            let guideView = BenefitGuideView(frame: .zero)
            guideView.icon.image = UIImage(systemName: guide.iconName) //받아온 딕셔너리의 iconName임을 받아서 적용
            guideView.title.text = guide.guide //받아온 딕셔너리의 guide텍스트값을 적용
            return guideView //guideView를 guideViews에 배열로 받음
        }
        guideViews.forEach { view in //받은 guideViews의 배열값을 하나씩 꺼냄
            self.verticalStackView.addArrangedSubview(view) //stackView의 가장 아래에 view 추가
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 60) //추가한 view의 높이 60 고정
            ])
        }
    }
}
