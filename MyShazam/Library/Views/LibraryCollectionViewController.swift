//
//  LibraryViewController.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 08/10/2020.
//

import UIKit

class LibraryCollectionViewController: UICollectionViewController, PageViewControllerProtocol
{
    private weak var loaderIndicator: UIActivityIndicatorView?
    
    var model: PageModel?
    var pagerViewControllerDelegate: PagerViewControllerDelegate?
    
    var libraryCollectionPresenter: LibraryCollectionPresenter?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.registerCollectionViewCells()
        self.configureCollectionView()
        self.setupActivityIndicator()
        self.retrieveData()
    }
}

// MARK: Data Source
extension LibraryCollectionViewController
{
    private func retrieveData()
    {
        guard let presenter = self.libraryCollectionPresenter else {
            return
        }
        
        presenter.retrieveData { [weak self] in
            self?.loaderIndicator?.stopAnimating()
            self?.reloadUI()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.libraryCollectionPresenter?.numberOfItems(in: section) ?? 0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return self.libraryCollectionPresenter?.numberOfSections ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let itemModel = self.libraryCollectionPresenter?.item(for: CollectionIndex(section: indexPath.section, row: indexPath.row)) else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemModel.identifier, for: indexPath)
        
        if let collectionViewCell = cell as? CollectionViewCellProtocol {
            collectionViewCell.populateCell(itemModel: itemModel)
        }
        
        return cell
    }
}

extension LibraryCollectionViewController
{
    func loadPageData()
    {
        self.retrieveData()
    }
}

// MARK: UI helpers
extension LibraryCollectionViewController {
    
    private func setupActivityIndicator()
    {
        let loader = UIActivityIndicatorView(style: .large)
        self.collectionView.addSubview(loader)
        loader.center = self.collectionView.center
        loader.startAnimating()
        self.loaderIndicator = loader
    }
    
    private func reloadUI()
    {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func configureCollectionView() {
        self.collectionView.backgroundColor = .white
        self.collectionView.collectionViewLayout = self.createCollectionViewLayout()
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func registerCollectionViewCells() {
        let libCell = UINib(nibName: "LibraryItemCell", bundle: nil)
        self.collectionView.register(libCell, forCellWithReuseIdentifier: "LibraryItemCell")
        let recentCell = UINib(nibName: "ShazamItemCell", bundle: nil)
        self.collectionView.register(recentCell, forCellWithReuseIdentifier: "ShazamItemCell")
        let seeAllCell = UINib(nibName: "ActionItemCell", bundle: nil)
        self.collectionView.register(seeAllCell, forCellWithReuseIdentifier: "ActionItemCell")
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            var columns = 1
            switch sectionIndex {
            case 1:
                columns = 2
            default:
                columns = 1
            }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let groupHeight = columns == 1 ? NSCollectionLayoutDimension.estimated(60) : NSCollectionLayoutDimension.estimated(300)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            return section
        }
        return layout
    }
}
