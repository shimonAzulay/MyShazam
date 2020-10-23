//
//  PerferenceModel.swift
//  MyShazam
//
//  Created by Shimon Azulay on 23/10/2020.
//

struct PreferenceModel
{
    var perferenceName: String
}

extension PreferenceModel: CollectionSectionItemModelProtocol
{
    var identifier: String {
        "PreferenceCell"
    }
}

extension PreferenceModel
{
    static func createData() -> [PreferenceModel]
    {
        [PreferenceModel(perferenceName: "iCloud Sync"),
        PreferenceModel(perferenceName: "Notifications"),
        PreferenceModel(perferenceName: "Location"),
        PreferenceModel(perferenceName: "Shazam on app start"),
        PreferenceModel(perferenceName: "Haptic Feedback")]
    }
}
