//
//  ShazamItemCell.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 09/10/2020.
//

import UIKit

class ShazamItemCell: UICollectionViewCell
{
    @IBOutlet weak var shazamImage: UIImageView!
    @IBOutlet weak var shazamSongName: UILabel!
    @IBOutlet weak var shazamArtistName: UILabel!
    
    override func willMove(toSuperview newSuperview: UIView?)
    {
        self.prepareUI()
    }
}

extension ShazamItemCell: CollectionViewCellProtocol
{
    func populateCell(itemModel: CollectionSectionItemModelProtocol)
    {
        guard let shazamItemModel = itemModel as? ShazamItem else {
            return
        }
        
        self.shazamSongName.text = shazamItemModel.shazamSongName
        self.shazamArtistName.text = shazamItemModel.shazamArtistName
    }
}

extension ShazamItemCell
{
    private func prepareUI()
    {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        self.layer.backgroundColor = UIColor.clear.cgColor

        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
}
