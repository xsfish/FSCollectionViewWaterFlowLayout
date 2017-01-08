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
        waterLayout.columnCount = 3
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: waterLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random()%60) + 20
    }
}
```
效果图如下

### License
FSCollectionViewWaterFlowLayout is available under the MIT license. See the LICENSE file for more info.
