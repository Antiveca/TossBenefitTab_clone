//
//  buttonBenefitViewController.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/25.
//

import UIKit
import Combine

class ButtonBenefitViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var verticalStackView: UIStackView!
    
    var buttonBenefitViewModel: ButtonBenefitViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        buttonBenefitViewModel.fetchDetails()
    }
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        actionButton.layer.masksToBounds = true //true면 버튼레이어 밖으로는 그리지 않음(https://babbab2.tistory.com/47)
        actionButton.layer.cornerRadius = 5
    }
    
    
    private func bind() {
        buttonBenefitViewModel.$benefit
            .receive(on: RunLoop.main)
            .sink { benefit in
                self.actionButton.setTitle(benefit.ctaTitle, for: .normal)
            }.store(in: &subscriptions)
        
        buttonBenefitViewModel.$benefitDetails
            .compactMap{ $0 }
            .receive(on: RunLoop.main)
            .sink { details in
                self.addGuides(details: details)
            }.store(in: &subscriptions)
    }
    
    private func addGuides(details: BenefitDetails) {
        let guideViews: [BenefitGuideView] = details.guides.map { guide in //benefitDetails.guides배열의 딕셔너리 값을 하나씩 받음
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
