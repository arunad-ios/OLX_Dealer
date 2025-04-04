//
//  OnlineBuyLead_Edit.swift
//  OLX_BuyLeads
//
//  Created by Chandini on 03/04/25.
//

import Foundation
import UIKit

class OnlineBuyLead_Edit : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    @IBOutlet weak var updateButton: UIButton!
    
    var sections = ["Customer Details", "Vehicle Details", "Lead Status", "Lead History"]
    var expandedSections: Set<Int> = [] // Track expanded sections
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Buy Lead"

        tableView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
     
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - TableView DataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expandedSections.contains(section) ? 1 : 0 // Show content only when expanded
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Details for \(sections[indexPath.section])"
        cell.textLabel?.font =  UIFont(name: "Roboto-Regular", size: 14)

        return cell
    }
    
    // MARK: - TableView Headers (Expandable Sections)
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .lightGray

        let titleLabel = UILabel(frame: CGRect(x: 16, y: 10, width: tableView.frame.width - 50, height: 30))
        titleLabel.text = sections[section]
        headerView.addSubview(titleLabel)

        let expandButton = UIButton(frame: CGRect(x: tableView.frame.width - 40, y: 10, width: 30, height: 30))
        expandButton.setTitle(expandedSections.contains(section) ? "▲" : "▼", for: .normal)
        expandButton.addTarget(self, action: #selector(toggleSection(_:)), for: .touchUpInside)
        expandButton.tag = section
        headerView.addSubview(expandButton)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    // MARK: - Expand/Collapse Logic

    @objc func toggleSection(_ sender: UIButton) {
        let section = sender.tag
        if expandedSections.contains(section) {
            expandedSections.remove(section)
        } else {
            expandedSections.insert(section)
        }
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        print("Update button tapped")
    }
}
