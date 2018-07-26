//
//  ThoughtsView.swift
//  Thoughts
//
//  Created by Dev on 7/2/18.
//  Copyright © 2018 Dev. All rights reserved.
//

import Foundation
import UIKit
import WCLShineButton

class ThoughtsView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .mainBlue
        setupSkeleton()
    }
    
    let sampleData = ThoughtsModal.init(catagory: Catagories.design, title: "How colors work", body: "fuckity fuck", avatar: #imageLiteral(resourceName: "toDo"), color: .mainYellow)
    
    let tableViewID = "tableVIewIdentifier"
    
    private func setupSkeleton() {
        addSubview(helloView)
        helloView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        helloView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        helloView.addSubview(thoughtsLabel)
        helloView.addSubview(search)
        helloView.addSubview(add)
        addSubview(tableView)
        
        tableView.register(ThoughtsTableViewCell.self, forCellReuseIdentifier: tableViewID)
        tableView.delegate = self
        tableView.dataSource = self
        
        thoughtsLabel.frame = CGRect(x: 10, y: 20, width: 150, height: 60)
        search.setAnchor(top: nil, leading: helloView.leadingAnchor, bottom: helloView.bottomAnchor, trailing: helloView.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 50)
        NSLayoutConstraint.activate([
            search.heightAnchor.constraint(equalToConstant: 44),
            add.leadingAnchor.constraint(equalTo: search.trailingAnchor, constant: 2),
            add.trailingAnchor.constraint(equalTo: safeTrailingAnchor),
            add.bottomAnchor.constraint(equalTo: helloView.bottomAnchor),
            add.topAnchor.constraint(equalTo: search.topAnchor),
            tableView.topAnchor.constraint(equalTo: helloView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let dateLabel = getDate()
        let date = dateLabel.buildTime(dateLabel)
        print(date.subviews)
        helloView.addSubview(date)
        date.setAnchor(top: safeTopAnchor, leading: nil, bottom: nil, trailing: helloView.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 10)
    }
    @objc func action(_ sender: WCLShineButton) {
        print("Clicked \(sender.isSelected)")
        print("fwk")
    }
    
    let helloView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkOverlay
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setHeightWidth(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6.5)
        return view
    }()
    let search : UISearchBar = {
        let sb = UISearchBar()
        sb.keyboardType = .default
        sb.isTranslucent = false
        sb.searchBarStyle = UISearchBarStyle.minimal
        return sb
    }()
    let add : UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .clear
        bt.layer.cornerRadius = 2
        bt.setImage(#imageLiteral(resourceName: "thoughts"), for: .normal)
        bt.addTarget(self, action: #selector(action(_:)), for: .touchUpInside)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    let thoughtsLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Thoughts"
        lbl.font = UIFont(name: "Comfortaa-light", size: 27)
        lbl.textColor = .white
        return lbl
    }()
    
    let tableView : UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.separatorStyle = .singleLine
        tb.separatorColor = .darkGray
        tb.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tb.showsVerticalScrollIndicator = true
        tb.allowsSelection = false
        tb.backgroundColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0)
        
        return tb
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}