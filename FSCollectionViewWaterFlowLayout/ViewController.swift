//
//  ViewController.swift
//  FSCollectionViewWaterFlowLayout
//
//  Created by fei on 17/1/7.
//  Copyright © 2017年 fei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FSCollectionViewDelegateWaterFlowLayout {

    var itemCount = 200
    
    lazy var collectionView: UICollectionView = {
        let waterFlowLayout = FSCollectionViewWaterFlowLayout()
        waterFlowLayout.columnCount = 3
        waterFlowLayout.columnMargin = 8
        waterFlowLayout.rowMargin = 10
        waterFlowLayout.edgeInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: waterFlowLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.register(FSWaterFlowCell.self, forCellWithReuseIdentifier: "FSWaterFlowCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view":collectionView])
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view":collectionView]))
        view.addConstraints(constraints)
    }
    
    
    
    //MARK: - UICollectionViewDateSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FSWaterFlowCell", for: indexPath) as! FSWaterFlowCell
        cell.backgroundColor = UIColor.random
        cell.textLabel.text = "\(indexPath.item)"
        return cell
    }
    
    // MARK: - FSCollectionViewDelegateWaterFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random()%60) + 30
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
    }
}

