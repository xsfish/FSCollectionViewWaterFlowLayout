import UIKit

class ImageViewController: UIViewController, FSCollectionViewDelegateWaterFlowLayout,UICollectionViewDataSource {
    
    lazy var imageNames: [String] = {
        var names: [String] = []
        for _ in 0..<100 {
            names.append("0\(1+arc4random()%5).jpg")
        }
        return names
    }()
    
    lazy var collectionView: UICollectionView = {
        let waterLayout = FSCollectionViewWaterFlowLayout()
        waterLayout.columnCount = 3   //设置列数
        waterLayout.columnMargin = 10 //设置列间距
        waterLayout.rowMargin = 10    //设置行间距
        waterLayout.edgeInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //设置与父视图的边距
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: waterLayout)
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self   //设置 FSCollectionViewDelegateWaterFlowLayout 的代理对象
        collectionView.register(UINib(nibName: "FSImageCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.frame = view.bounds
        /*
         var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view":collectionView])
         constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view":collectionView]))
         collectionView.addConstraints(constraints)
 */
        
    }
    
    ///MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FSImageCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])
        cell.textLabel.text = imageNames[indexPath.item]
        cell.backgroundColor = UIColor.white
        cell.textLabel.textColor = UIColor.white
        cell.textLabel.backgroundColor = UIColor.gray
        return cell
    }
    
    ///MARK: - FSCollectionViewDelegateWaterFlowLayout
    func collectionView(_ collectionView: UICollectionView, itemWidth: CGFloat, heightForItemAt indexPath: IndexPath) -> CGFloat {
        let imageSize = UIImage(named: imageNames[indexPath.row])!.size
        let imageHeight = imageSize.height / imageSize.width * itemWidth
        let textHeight: CGFloat = 20
        return imageHeight + textHeight
    }
}
