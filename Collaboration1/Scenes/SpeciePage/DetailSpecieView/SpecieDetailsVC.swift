//
//  SpecieDetailsVC.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import UIKit

final class SpecieDetailsVC: UIViewController {
    // MARK: - Properties
    let viewModel = SpecieDetailsVM()
    private var dataSource: UICollectionViewDiffableDataSource<Int, NaturalistInfo.Taxon>!

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(300))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(300))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(10)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            return section
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SpecieCollectionViewCell.self, forCellWithReuseIdentifier: SpecieCollectionViewCell.identifier)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(hex: "262A34")
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDataSource()
        setupBindings()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Bind ViewModel
    private func setupBindings() {
        viewModel.onSpeciesInfoUpdate = { [weak self] species in
            self?.updateSnapshot(with: species)
        }
    }
}


extension SpecieDetailsVC: UICollectionViewDelegate {
    // MARK: - Setup Data Source
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, NaturalistInfo.Taxon>(collectionView: collectionView) { collectionView, indexPath, taxon in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecieCollectionViewCell.identifier, for: indexPath) as? SpecieCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: taxon)
            cell.setWikipediaAction {
                if let urlString = taxon.wikipediaUrl, let url = URL(string: urlString) {
                    UIApplication.shared.open(url)
                }
            }
            return cell
        }
    }
    
    // MARK: - Update Snapshot
    private func updateSnapshot(with species: [NaturalistInfo.Taxon]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, NaturalistInfo.Taxon>()
        snapshot.appendSections([0])
        snapshot.appendItems(species)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    @objc private func openWikipedia(_ sender: UIButton) {
        if let indexPath = collectionView.indexPath(for: sender.superview?.superview as! SpecieCollectionViewCell) {
            let taxon = dataSource.itemIdentifier(for: indexPath)
            if let urlString = taxon?.wikipediaUrl, let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
}
