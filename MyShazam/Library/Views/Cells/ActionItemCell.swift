//
//  ActionItemCell.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 09/10/2020.
//

import UIKit

class ActionItemCell: UICollectionViewCell
{
    @IBOutlet weak var actionButton: UIButton!
    
    override func willMove(toSuperview newSuperview: UIView?) {
        prepareUI()
    }
}


extension ActionItemCell: CollectionViewCellProtocol
{
    func populateCell(itemModel: CollectionSectionItemModelProtocol)
    {
        guard let actionItemModel = itemModel as? ActionItem else {
            return
        }
        
        self.actionButton.setTitle(actionItemModel.actionName, for: .normal)
    }
}

extension ActionItemCell
{
    private func prepareUI()
    {
        self.actionButton.layer.cornerRadius = self.actionButton.frame.height / 2
    }
}
