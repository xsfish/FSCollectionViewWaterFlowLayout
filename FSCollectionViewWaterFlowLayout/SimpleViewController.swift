import UIKit

class SimpleViewController: UIViewController, FSCollectionViewDelegateWaterFlowLayout, UICollectionViewDataSource {
    
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

