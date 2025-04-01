//
//  OnlineBuyLeads_collection.swift
//  OLX_BuyLeads
//
//  Created by Chandini on 01/04/25.
//

import Foundation
import UIKit

class OnlineBuyLeads_collection : UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "CustomTableViewCell"
    
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // Scroll horizontally
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var items: [Any] = [] // Sample data

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        contentView.backgroundColor = .clear
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OnlineBuyLeads_collectioncell.self, forCellWithReuseIdentifier: OnlineBuyLeads_collectioncell.identifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100) // Set a fixed height
        ])
    }
    
    func configure(with items: [Any]) {
        self.items = items
        collectionView.reloadData()
    }

    // MARK: - UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnlineBuyLeads_collectioncell.identifier, for: indexPath) as! OnlineBuyLeads_collectioncell
        let dic = items[indexPath.item] as! NSDictionary
        print((dic["name"] as! String))
        cell.configure(title: "\((dic["name"] as! String))\(((dic["count"] as! CVarArg)))")
        return cell
    }

    // MARK: - UICollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dic = items[indexPath.item] as! NSDictionary
        let text = "\((dic["name"] as! String))\((dic["count"] as! CVarArg))" // Example: Get text for cell
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 50
        return CGSize(width: width, height: 30)
    }
}
