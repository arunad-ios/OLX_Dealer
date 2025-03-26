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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var items: [String] = []  // Sample data source

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
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 120)  // Adjust as needed
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
    }
    
    public func configure(with items: [String]) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        self.items = items
        collectionView.reloadData()
        DispatchQueue.main.async {
               if let tableView = self.superview as? UITableView {
                   tableView.beginUpdates()
                   tableView.endUpdates()
               }
           }
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        cell.backgroundColor = .blue  // Customize cell appearance
        return cell
    }
    public  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let text = items[indexPath.item] // Example: Get text for cell
           let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 20
           return CGSize(width: width, height: 50) // Dynamic width, fixed height
       }
}
