//
//  SettingsPresenter.swift
//  MyShazam
//
//  Created by Shimon Azulay on 23/10/2020.
//

protocol SettingsPresenterProtocol
{
    var model: CollectionModel { get }
}

class SettingsPresenter: SettingsPresenterProtocol
{
    var model: CollectionModel {
        DataSource.getSettingsData()
    }
    
}
