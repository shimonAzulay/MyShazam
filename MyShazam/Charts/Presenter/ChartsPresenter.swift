//
//  ChartsPresenter.swift
//  MyShazam
//
//  Created by Shimon Azulay on 16/10/2020.
//

protocol ChartsPresenterProtocol
{
    var numberOfSections: Int { get }
    
    func retrieveData(complition: (() -> Void)?)
    func numberOfItems(in section: Int) -> Int
    func item(for index: CollectionIndex) -> CollectionSectionItemModelProtocol?
}

class ChartsPresenter: ChartsPresenterProtocol
{
    private var chartsModel: CollectionModel?
    
    var numberOfSections: Int { self.chartsModel?.sections.count ?? 0 }
    
    func retrieveData(complition: (() -> Void)?)
    {
        DataSource.getChartsData { collectionModel in
            self.chartsModel = collectionModel
            complition?()
        }
    }
    
    func numberOfItems(in section: Int) -> Int
    {
        guard section < self.numberOfSections else {
            return 0
        }
        
        return self.chartsModel?.sections[section].sectionItems.count ?? 0
    }
    
    func item(for index: CollectionIndex) -> CollectionSectionItemModelProtocol?
    {
        guard index.section < self.numberOfSections else  {
            return nil
        }
        
        guard index.row < self.numberOfItems(in: index.section) else {
            return nil
        }
        
        guard let item = self.chartsModel?.sections[index.section].sectionItems[index.row] else {
            return nil
        }
        
        return item
    }
}
