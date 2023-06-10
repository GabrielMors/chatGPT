//
//  OutgoingTextTableViewCell.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/06/23.
//

import UIKit

class OutgoingTextTableViewCell: UITableViewCell {
    
    static let identefier: String = String(describing: OutgoingTextTableViewCell.self)
    
    lazy var messageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius  = 22
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
        view.backgroundColor = .purple
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.fontMessage.rawValue, size: 16)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .backGround
        selectionStyle = .none
        addElements()
        
    }
    
    private func addElements() {
        contentView.addSubview(messageView)
        messageView.addSubview(messageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
