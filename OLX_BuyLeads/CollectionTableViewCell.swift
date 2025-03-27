import UIKit
import Foundation

public class CollectionTableViewCell: UITableViewCell {
    
    public static let identifier = "CollectionTableViewCell"
    
    @IBOutlet var collectionView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical  // Change to .vertical if needed
        layout.itemSize = CGSize(width: 100, height: 30)  // Adjust size
        layout.minimumLineSpacing = 10  // Spacing between items
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
     //   collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var items: [Any] = []  // Sample data source

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

    private func setupCollectionView() {
        contentView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 120)  // Adjust as needed
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
    
    public func configure(with items: [Any]) {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let bundle1 = Bundle(for: CollectionViewCell.self)
        let nib1 = UINib(nibName: "CollectionViewCell", bundle: bundle1)
        collectionView.register(nib1, forCellWithReuseIdentifier: "CollectionViewCell")

        self.items = items
        print("Response Data: \(self.items) \(self.items.count)")
        collectionView.reloadData()
        DispatchQueue.main.async {
               if let tableView = self.superview as? UITableView {
                   tableView.beginUpdates()
                   tableView.endUpdates()
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
