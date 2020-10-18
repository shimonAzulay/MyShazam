//
//  ChartsPresenter.swift
//  MyShazam
//
//  Created by Shimon Azulay on 16/10/2020.
//

protocol ChartsPresenterProtocol
{
    var title: String { get }
    func retrieveData(complition: ((_ collectionModel: CollectionModel) -> Void)?)
}

class ChartsPresenter: ChartsPresenterProtocol
{
    private var chartsModel: CollectionModel?
    
    var title: String = "Charts"
    
    func retrieveData(complition: ((_ collectionModel: CollectionModel) -> Void)?)
    {
        DataSource.getChartsData { collectionModel in
            self.chartsModel = collectionModel
            complition?(collectionModel)
        }
    }
}
