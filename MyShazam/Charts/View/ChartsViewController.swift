//
//  ChartsViewController.swift
//  MyShazam
//
//  Created by Shimon Azulay on 16/10/2020.
//

import UIKit

class ChartsViewController: UIViewController, PageViewControllerProtocol
{
    private var collectionModel: CollectionModel?
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model: PageModel?
    var pagerViewControllerDelegate: PagerViewControllerDelegate?
    
    var chartsPresenter: ChartsPresenterProtocol?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.registerCollectionViewCells()
        self.configureCollectionView()
        self.configureTitle()
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
    
    private func configureTitle()
    {
        guard let presenter = self.chartsPresenter else {
            self.pageTitle.text = ""
            return
        }
        
        self.pageTitle.text = presenter.title
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
        let aroundTheWorldChartsCell = UINib(nibName: AroundTheWorldChartsCell.nibName, bundle: nil)
        self.collectionView.register(aroundTheWorldChartsCell, forCellWithReuseIdentifier: AroundTheWorldChartsCell.resuableId)
        let chartCell = UINib(nibName: ChartCell.nibName, bundle: nil)
        self.collectionView.register(chartCell, forCellWithReuseIdentifier: ChartCell.resuableId)
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
