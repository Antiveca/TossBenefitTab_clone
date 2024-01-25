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

class BenefitListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = AnyHashable

    enum Section:Int {
        case today
        case other
    }

    var datasource: UICollectionViewDiffableDataSource<Section, Item>!

//    var todaySectionItems: [AnyHashable] = [MyPoint.default, Benefit.today]
    var todaySectionItems: [AnyHashable] = TodaySectionItem(point: .default, today: .today).sectionItems
    var otherSectionItems: [AnyHashable] = Benefit.others
//
    override func viewDidLoad() {
        super.viewDidLoad()

        //data, presentation, layout
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil }

            let cell = self.configureCell(for: section, item: item, collectionView: collectionView, indexPath: indexPath)

            return cell
        })

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.today, .other])
        snapshot.appendItems(todaySectionItems, toSection: .today)
        snapshot.appendItems(otherSectionItems, toSection: .other)
        datasource.apply(snapshot)

        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self

        navigationItem.title = "혜택"
        
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
//        case .other:
//            if let benefit = item as? Benefit {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitCell", for: indexPath) as! BenefitCell
//                cell.configure(item: benefit)
//                return cell
//            } else { return nil }
        case .other:
            guard let benefit = item as? Benefit else { return nil }

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitCell", for: indexPath) as! BenefitCell
            cell.configure(item: benefit)
            return cell
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = datasource.itemIdentifier(for: indexPath)
        print("----> \(item)")
        
        if let benefit = item as? Benefit {
            
        } else if let point = item as? MyPoint {
            let sb = UIStoryboard(name: "MyPoint", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MyPointViewController") as! MyPointViewController
            vc.point = point
            navigationController?.pushViewController(vc, animated: true)
        } else {}
    }
}
