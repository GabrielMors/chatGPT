//
//  OutgoingTextTableViewCell.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/06/23.
//

import UIKit

class OutgoingTextTableViewCell: UITableViewCell {
    
    static let identefier: String = String(describing: OutgoingTextTableViewCell.self)
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
