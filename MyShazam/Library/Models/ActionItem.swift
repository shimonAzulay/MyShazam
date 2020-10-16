//
//  ActionItem.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 10/10/2020.
//

import Foundation

struct ActionItem: CollectionSectionItemModelProtocol {
    
    var identifier: String {
        "ActionItemCell"
    }
    
    var actionName: String
}

extension ActionItem
{
    static func createData() -> [ActionItem] { [ActionItem(actionName: "SEE ALL")] }
}
