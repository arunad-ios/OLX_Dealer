import UIKit
import Foundation

public class CollectionTableViewCell: UITableViewCell {
    
    public static let identifier = "CollectionTableViewCell"
    
    @IBOutlet var collectionViewHeightConstraint : NSLayoutConstraint!
    
    @IBOutlet var collectionView: UICollectionView!
    
    private var items: [Any] = []  // Sample data source

    
    public override func awakeFromNib() {
           super.awakeFromNib()
           collectionView.delegate = self
           collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let bundle1 = Bundle(for: CollectionViewCell.self)
        let nib1 = UINib(nibName: "CollectionViewCell", bundle: bundle1)
        collectionView.register(nib1, forCellWithReuseIdentifier: "CollectionViewCell")
       }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    func updateCollectionViewHeight() {
           DispatchQueue.main.async {
               self.collectionViewHeightConstraint.constant = self.collectionView.contentSize.height
               self.superview?.layoutIfNeeded()
           }
       }
    public override func layoutSubviews() {
          super.layoutSubviews()
          updateCollectionViewHeight()
      }
    public func configure(with items: [Any]) {
        if(self.items.count == 0){
            self.items = items
            print("Response Data: \(self.items) \(self.items.count)")
            collectionView.reloadData()
            collectionView.layoutIfNeeded()
                    DispatchQueue.main.async {
                           if let tableView = self.superview as? UITableView {
                               tableView.beginUpdates()
                               tableView.endUpdates()
                           }
                       }
        }
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CollectionCellDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

        let dic = items[indexPath.item] as! NSDictionary
        print((dic["name"] as! String))
        cell.myLabel.text = (dic["name"] as! String)
        cell.myButton.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.myButton.addTarget(self, action: #selector(popup), for: .touchUpInside)
        cell.imagesvg.image = UIImage(named: "uncheck")
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0).cgColor
        cell.isUserInteractionEnabled = true
        cell.contentView.isUserInteractionEnabled = true
        return cell
    }
    @objc func popup()
    {
        guard let topVC = UIApplication.shared.windows.first?.rootViewController else {
            print("No root view controller found")
            return
        }
        let alert = UIAlertController(title: "SDK Alert", message: "Hello from SDK!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
    public  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let dic = items[indexPath.item] as! NSDictionary
           let text = (dic["name"] as! String) // Example: Get text for cell
           let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 50
           return CGSize(width: width, height: 30) // Dynamic width, fixed height
       }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Button tapped in UICollectionViewCell inside UITableViewCell")
    }
    func didTapButton(in cell: CollectionViewCell) {
           print("Button tapped in UICollectionViewCell inside UITableViewCell")
           if let indexPath = collectionView.indexPath(for: cell) {
               print("Tapped item at row \(indexPath.row)")
           }
       }
}
