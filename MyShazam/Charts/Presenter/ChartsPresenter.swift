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
    var numberOfSections: Int {
        0
    }
    
    func retrieveData(complition: (() -> Void)?)
    {
    }
    
    func numberOfItems(in section: Int) -> Int
    {
        0
    }
    
    func item(for index: CollectionIndex) -> CollectionSectionItemModelProtocol?
    {
        nil
    }
}
