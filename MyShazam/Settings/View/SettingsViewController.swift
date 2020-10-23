//
//  SettingsViewController.swift
//  MyShazam
//
//  Created by Shimon Azulay on 23/10/2020.
//

import UIKit

class SettingsViewController: UIViewController
{
    private var collectionModel: CollectionModel?
    
    var settingsPresenter: SettingsPresenterProtocol?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.registerCollectionViewCells()
        self.configureCollectionView()
        self.retrieveData()
    }
}

extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    private func retrieveData()
    {
        guard let presenter = self.settingsPresenter else {
            return
        }
        
        self.collectionModel = presenter.model
        self.reloadUI()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.collectionModel?.sections[section].sectionItems.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return self.collectionModel?.sections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let itemModel = self.collectionModel?.sections[indexPath.section].sectionItems[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemModel.identifier, for: indexPath)
        
        if let collectionViewCell = cell as? CollectionViewCellProtocol {
            collectionViewCell.populateCell(itemModel: itemModel)
        }
        
        return cell
    }
}

extension SettingsViewController
{
    private func reloadUI()
    {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func configureCollectionView()
    {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = self.createCollectionViewLayout()
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func registerCollectionViewCells()
    {
        let streamingCell = UINib(nibName: StreamingCell.nibName, bundle: nil)
        self.collectionView.register(streamingCell, forCellWithReuseIdentifier: StreamingCell.resuableId)
        let preferenceCell = UINib(nibName: PreferenceCell.nibName, bundle: nil)
        self.collectionView.register(preferenceCell, forCellWithReuseIdentifier: PreferenceCell.resuableId)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout
    {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupHeight = sectionIndex == 0 ? NSCollectionLayoutDimension.estimated(80) : NSCollectionLayoutDimension.estimated(60)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return layout
    }
}
