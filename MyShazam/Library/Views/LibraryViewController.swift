//
//  LibraryViewController.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 08/10/2020.
//

import UIKit

class LibraryViewController: UIViewController, PageViewControllerProtocol
{
    private var collectionModel: CollectionModel?
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var model: PageModel?
    var pagerViewControllerDelegate: PagerViewControllerDelegate?
    
    // MARK: TODO - Create LibraryPesenter
    var libraryPresenter: LibraryPresenter?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.registerCollectionViewCells()
        self.configureCollectionView()
        self.configureTitle()
        self.view.bringSubviewToFront(self.activityIndicator)
        self.retrieveData()
    }
    
    @IBAction func settingsTapped(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsViewController else { return }
        vc.settingsPresenter = SettingsPresenter()
    
        self.show(vc, sender: self)
    }
}

// MARK: Data Source
extension LibraryViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    private func retrieveData()
    {
        guard let presenter = self.libraryPresenter else {
            return
        }
        
        presenter.retrieveData { [weak self] collectionModel in
            self?.collectionModel = collectionModel
            self?.activityIndicator.stopAnimating()
            self?.reloadUI()
        }
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
        
        if let collectionViewCell = cell as? CollectionViewCellProtocol
        {
            collectionViewCell.populateCell(itemModel: itemModel)
        }
        
        return cell
    }
}

// MARK: UI helpers
extension LibraryViewController {
    
    private func reloadUI()
    {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func configureTitle()
    {
        guard let presenter = self.libraryPresenter else {
            self.pageTitle.text = ""
            return
        }
        
        self.pageTitle.text = presenter.title
    }
    
    private func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = self.createCollectionViewLayout()
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func registerCollectionViewCells() {
        let libCell = UINib(nibName: LibraryItemCell.nibName, bundle: nil)
        self.collectionView.register(libCell, forCellWithReuseIdentifier: LibraryItemCell.resuableId)
        let recentCell = UINib(nibName: ShazamItemCell.nibName, bundle: nil)
        self.collectionView.register(recentCell, forCellWithReuseIdentifier: ShazamItemCell.resuableId)
        let seeAllCell = UINib(nibName: ActionItemCell.nibName, bundle: nil)
        self.collectionView.register(seeAllCell, forCellWithReuseIdentifier: ActionItemCell.resuableId)
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
