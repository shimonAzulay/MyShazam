//
//  SteamingCell.swift
//  MyShazam
//
//  Created by Shimon Azulay on 23/10/2020.
//

import UIKit

class StreamingCell: UICollectionViewCell
{
    @IBOutlet weak var streamName: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    override func willMove(toSuperview newSuperview: UIView?)
    {
        super.willMove(toSuperview: newSuperview)
        self.prepareUI()
    }
}

extension StreamingCell: CollectionViewCellProtocol
{
    static var nibName: String {
        "StreamingCell"
    }
    
    static var resuableId: String {
        String(describing: Self.self)
    }
    
    func populateCell(itemModel: CollectionSectionItemModelProtocol)
    {
        guard let streamingModel = itemModel as? StreamingModel else {
            return
        }
        
        self.streamName.text = streamingModel.streamingName
        self.actionButton.setTitle(streamingModel.actionName, for: .normal)
    }
}

extension StreamingCell
{
    private func prepareUI()
    {
        self.actionButton.layer.cornerRadius = self.actionButton.frame.height / 2
    }
}
