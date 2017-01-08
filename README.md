# FSCollectionViewWaterFlowLayout

collectionview water fall flow layout 简单可自定义的瀑布流。

### Requirements

- iOS 8.0+ 
- Swift 3 

### Install

- cocoapods
  - pod 'FSCollectionViewWaterFlowLayout'
- 手动安装
  - 将 FSCollectionViewWaterFlowLayout.swift 文件拖到你的工程中。 
  
### Example

下面是一个简单的使用例子
```swift
import UIKit
import FSCollectionViewWaterFlowLayout
class ViewController: UIViewController, FSCollectionViewDelegateWaterFlowLayout,UICollectionViewDataSource {

    lazy var collectionView: UICollectionView = {
        let waterLayout = FSCollectionViewWaterFlowLayout()
        waterLayout.columnCount = 3   //设置列数
        waterLayout.columnMargin = 10 //设置列间距
        waterLayout.rowMargin = 10    //设置行间距
        waterLayout.edgeInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10) //设置与父视图的边距
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: waterLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self   //设置 FSCollectionViewDelegateWaterFlowLayout 的代理对象
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
    }

    ///MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.purple
        return cell
    }
    
    ///MARK: - FSCollectionViewDelegateWaterFlowLayout
    func collectionView(_ collectionView: UICollectionView, itemWidth: CGFloat, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random()%60) + 20
    }
}
```
- 效果图如下
  - ![image](https://github.com/Fredcom/FSCollectionViewWaterFlowLayout/blob/master/ScreenShot/ScreenShot.png)
  
#### 带图片的效果图如下
  ![image](https://github.com/Fredcom/FSCollectionViewWaterFlowLayout/blob/master/ScreenShot/ScreenShot2.jpg)

### License

FSCollectionViewWaterFlowLayout is released under the MIT license. See LICENSE for details.
