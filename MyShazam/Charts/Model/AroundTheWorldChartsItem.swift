//
//  AroundTheWorldChartsItem.swift
//  MyShazam
//
//  Created by Shimon Azulay on 17/10/2020.
//

struct AroundTheWorldChartsItem: CollectionSectionItemModelProtocol
{
    var identifier: String {
        "AroundTheWorldChartsCell"
    }
}

extension AroundTheWorldChartsItem
{
    static func createData() -> [AroundTheWorldChartsItem]
    {
        [AroundTheWorldChartsItem()]
    }
}
