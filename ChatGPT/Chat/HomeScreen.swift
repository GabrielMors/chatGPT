//
//  HomeScreen.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 09/06/23.
//

import UIKit

class HomeScreen: UIView {
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .backGround
        
        return tableView
    }()
    
    lazy var contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backGround
        
        return view
    }()
    
    lazy var subContentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
}
