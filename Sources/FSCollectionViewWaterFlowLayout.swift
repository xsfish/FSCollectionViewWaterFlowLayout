//
//  FSCollectionViewWaterFlowLayout.swift
//  FSCollectionViewWaterFlowLayout
//
//  Created by fei on 17/1/7.
//  Copyright © 2017年 fei. All rights reserved.
//

import UIKit

public protocol FSCollectionViewDelegateWaterFlowLayout: UICollectionViewDelegate {
    
    /// return height for item at indexPath
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, heightForItemAt indexPath: IndexPath) -> CGFloat
}

public class FSCollectionViewWaterFlowLayout: UICollectionViewFlowLayout {

    public var columnCount = 2
    public var columnMargin:CGFloat = 10
    public var rowMargin:CGFloat = 10
    public var edgeInset = UIEdgeInsets.zero
    
    private var contentHeight:CGFloat = 0.0
    private var columnHeights:[CGFloat] = []

    private var attrsArray:[UICollectionViewLayoutAttributes] = []
    
    public override func prepare() {
        super.prepare()
        
        contentHeight = 0
        columnHeights.removeAll()
        
        for _ in 0..<columnCount {
            columnHeights.append(self.edgeInset.top) //edgeInset -- 兼容
        }
        
        //清除之前所有的布局属性数据
        attrsArray.removeAll()
        let count = collectionView?.numberOfItems(inSection: 0) //兼容
        
        //开始创建每一个cell对应的布局属性
        for index in 0..<(count ?? 0) {
            let indexPath = IndexPath(item: index, section: 0) //兼容
            //获取cell布局属性,在layoutAttributesForItemAtIndexPath里面计算具体的布局信息
            let attrs = layoutAttributesForItem(at: indexPath)
            if let tempAttrs = attrs {
                attrsArray.append(tempAttrs)
            }
            
        }
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = super.layoutAttributesForItem(at: indexPath)
        
        let collectionViewW = collectionView?.frame.width ?? 0
        let width = (collectionViewW - edgeInset.left - edgeInset.right - (CGFloat(columnCount) - 1) * columnMargin) / CGFloat(columnCount)
        
        let layoutDelegate = collectionView?.delegate as? FSCollectionViewDelegateWaterFlowLayout
        let height: CGFloat = layoutDelegate?.collectionView(collectionView!, layout: self, heightForItemAt: indexPath) ?? 44 //CGFloat(arc4random()%100)+50
        
        //找到数组内目前高度最小的那一列
        var destColumn = 0
        var minColumnHeight = columnHeights[destColumn]
        
        for index in 1..<columnCount {
            let columnHeight = columnHeights[index]
            if minColumnHeight > columnHeight {
                minColumnHeight = columnHeight
                destColumn = index
            }
        }
        
        //根据列信息，计算出origin.x
        let x = edgeInset.left + CGFloat(destColumn) * (width + columnMargin)
        var y = minColumnHeight
        if y != edgeInset.top {
            y += rowMargin
        }
        
        attrs?.frame = CGRect(x: x, y: y, width: width, height: height)
        
        //更新最短列高度
        columnHeights[destColumn] = attrs?.frame.maxY ?? 0
        let columnHeight = columnHeights[destColumn]
        if contentHeight < columnHeight {
            contentHeight = columnHeight
        }
        
        return attrs
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var rectArray:[UICollectionViewLayoutAttributes] = []
        for cacheAttr in attrsArray {
            if cacheAttr.frame.intersects(rect) {
                rectArray.append(cacheAttr)
            }
        }
        return rectArray
    }
    
    public override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.bounds.width ?? 0, height: contentHeight + edgeInset.bottom)
    }
    
}
