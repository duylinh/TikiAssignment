//
//  KeywordCell.swift
//  Shared
//
//  Created by DUYLINH on 5/4/19.
//  Copyright © 2019 DUYLINH. All rights reserved.
//

import UIKit

final class KeywordCell: UICollectionViewCell {
    
    static let ID = "KeywordCell"
    static var nib: UINib {
        return UINib.init(nibName: ID, bundle: Bundle.main)
    }
    static let font = UIFont.systemFont(ofSize: 14.0)
    
    fileprivate let colors = [
        UIColor(hexString: "#16702e"),
        UIColor(hexString: "#005a51"),
        UIColor(hexString: "#996c00"),
        UIColor(hexString: "#5c0a6b"),
        UIColor(hexString: "#006d90"),
        UIColor(hexString: "#974e06"),
        UIColor(hexString: "#99272e"),
        UIColor(hexString: "#89221f"),
        UIColor(hexString: "#00345d")
    ]
    
    @IBOutlet private weak var keywordImageView: UIImageView!
    @IBOutlet private weak var keywordLabel: PaddingLabel!
    
    override public func prepareForReuse() {
        keywordImageView.image = nil
        keywordLabel.text = nil
        keywordLabel.backgroundColor = UIColor.clear
    }
    
    func configure(with model: Keyword, indexPath: IndexPath) {
        keywordLabel.text = KeywordHelper.createNewKeyword(with: model.keyword ?? "")
        keywordLabel.textColor = .white
        keywordLabel.backgroundColor = colors[indexPath.row % colors.count]
        keywordLabel.rounded()
        if let imageUrlString = model.icon, let imageUrl = URL(string: imageUrlString) {
            keywordImageView.setImage(url: imageUrl)
        }
    }
    
}

