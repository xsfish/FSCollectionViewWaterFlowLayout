//
//  FSWaterFlowCell.swift
//  FSCollectionViewWaterFlowLayout
//
//  Created by fei on 17/1/7.
//  Copyright © 2017年 fei. All rights reserved.
//

import UIKit

class FSWaterFlowCell: UICollectionViewCell {
    
    lazy var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
    func initUI() {
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[view]-|", options: [], metrics: nil, views: ["view":textLabel])
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view]-|", options: [], metrics: nil, views: ["view":textLabel]))
        contentView.addConstraints(constraints)
    }
}
