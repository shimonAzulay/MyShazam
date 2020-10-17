//
//  ChartsViewController.swift
//  MyShazam
//
//  Created by Shimon Azulay on 16/10/2020.
//

import UIKit

class ChartsViewController: UIViewController, PageViewControllerProtocol
{
    var model: PageModel?
    var pagerViewControllerDelegate: PagerViewControllerDelegate?
    
    var chartsPresenter: ChartsPresenterProtocol?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.registerCollectionViewCells()
        self.configureCollectionView()
        self.view.bringSubviewToFront(self.activityIndicator)
        self.retrieveData()
    }
}

extension ChartsViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    private func retrieveData()
    {
        guard let presenter = self.chartsPresenter else {
            return
        }
        
        presenter.retrieveData { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.reloadUI()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.chartsPresenter?.numberOfItems(in: section) ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return self.chartsPresenter?.numberOfSections ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let itemModel = self.chartsPresenter?.item(for: CollectionIndex(section: indexPath.section, row: indexPath.row)) else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemModel.identifier, for: indexPath)
        
        if let collectionViewCell = cell as? CollectionViewCellProtocol {
            collectionViewCell.populateCell(itemModel: itemModel)
        }
        
        return cell
    }
}

extension ChartsViewController
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
        let libCell = UINib(nibName: "AroundTheWorldChartsCell", bundle: nil)
        self.collectionView.register(libCell, forCellWithReuseIdentifier: "AroundTheWorldChartsItemCell")
        let recentCell = UINib(nibName: "ChartCell", bundle: nil)
        self.collectionView.register(recentCell, forCellWithReuseIdentifier: "ChartItemCell")
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout
    {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupHeight = sectionIndex == 0 ? NSCollectionLayoutDimension.estimated(200) : NSCollectionLayoutDimension.estimated(350)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return layout
    }
}
