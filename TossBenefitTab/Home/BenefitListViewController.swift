//
//  BenefitListViewController.swift
//  TossBenefitTab
//
//  Created by ByeongGuk Choi on 2024/01/23.
//
//사용자는 포인트, 오늘의 혜택, 나머지 해택 리스트가 보임

//포인트를 셀을 누르면 포인트 상세뷰로 넘어감
//혜택관련 셀을 누르면 혜택 상세뷰로 넘어감

import UIKit
import Combine

class BenefitListViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = AnyHashable
    
    enum Section:Int {
        case today
        case other
    }
    
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
//    @Published var todaySectionItems: [AnyHashable] = []
//    @Published var otherSectionItems: [AnyHashable] = []
    let benefitListViewModel: BenefitListViewModel = BenefitListViewModel()
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureCollectionView()
        bind()
        benefitListViewModel.fetchItems()
    }
    
//    override func viewDidAppear(_ animated: Bool) { //viewDidAppear는 view가 화면에 완전히 나타난 후에 후출됨
//        super.viewDidAppear(animated)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //0.5초 딜레이로 받음(느린 네트워크 상황을 묘사)
//            self.todaySectionItems = TodaySectionItem(point: .default, today: .today).sectionItems
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { //2.5초 딜레이로 받음(느린 네트워크 상황을 묘사)
//            self.otherSectionItems = Benefit.others
//        }
//    }
    
    private func setupUI() {
        navigationItem.title = "혜택"
    }
    
    private func configureCollectionView() {
        //data, presentation, layout
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            
            let cell = self.configureCell(for: section, item: item, collectionView: collectionView, indexPath: indexPath)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.today, .other])
        snapshot.appendItems([], toSection: .today)
        snapshot.appendItems([], toSection: .other)
        datasource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
    }
    
    private func bind() {
        benefitListViewModel.$todaySectionItems
            .receive(on: RunLoop.main)
            .sink { items in
                self.applySnapshot(items: items, section: Section.today)
            }.store(in: &subscriptions)
        
        benefitListViewModel.$otherSectionItems
            .receive(on: RunLoop.main)
            .sink { items in
                self.applySnapshot(items: items, section: Section.other)
            }.store(in: &subscriptions)
        
        benefitListViewModel.benefitDidTapped
            .receive(on: RunLoop.main)
            .sink { benefit in
                let sb = UIStoryboard(name: "ButtonBenefit", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "ButtonBenefitViewController") as! ButtonBenefitViewController
                vc.buttonBenefitViewModel = ButtonBenefitViewModel(benefit: benefit)
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
        
        benefitListViewModel.pointDidTapped
            .receive(on: RunLoop.main)
            .sink { point in
                let sb = UIStoryboard(name: "MyPoint", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MyPointViewController") as! MyPointViewController
                vc.myPointViewModel = MyPointViewModel(point: point)
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
    }
    
    private func applySnapshot(items: [Item], section:Section) {
        var snapshot = datasource.snapshot()
        snapshot.appendItems(items, toSection: section)
        datasource.apply(snapshot)
    }
    
    private func configureCell(for section: Section, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        
        switch section {
        case .today:
            if let point = item as? MyPoint {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPointCell", for: indexPath) as! MyPointCell
                cell.configure(item: point)
                return cell
            } else if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayBenefitCell", for: indexPath) as! TodayBenefitCell
                cell.configure(item: benefit)
                return cell
            } else { return nil }
        case .other:
            if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitCell", for: indexPath) as! BenefitCell
                cell.configure(item: benefit)
                return cell
            } else { return nil }
            //        case .other:
            //            guard let benefit = item as? Benefit else { return nil }
            //
            //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitCell", for: indexPath) as! BenefitCell
            //            cell.configure(item: benefit)
            //            return cell
        }
    }
    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 10
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = spacing
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension BenefitListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { //indexPath로 선택한 아이템의 값을 받음
        let item = datasource.itemIdentifier(for: indexPath)
        
        if let benefit = item as? Benefit { //클릭되면 if로 어떤 아이템인지 확인하여 send로 값을 보내서 스토리보드를 띄움
            benefitListViewModel.benefitDidTapped.send(benefit)
        } else if let point = item as? MyPoint {
            benefitListViewModel.pointDidTapped.send(point)
        } else {}
    }
}
