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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
