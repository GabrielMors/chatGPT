//
//  HomeScreen.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 09/06/23.
//

import UIKit

protocol HomeScreenProtocol: AnyObject {
    func tappedButton(text: String)
}

class HomeScreen: UIView {
    
    private weak var delegate: HomeScreenProtocol?
    
    public func delegate(delegate: HomeScreenProtocol) {
        self.delegate = delegate
    }
    
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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = .default
        textField.placeholder = "type here:"
        textField.borderStyle = .none
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton ( )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkBlue
        button.isEnabled = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setImage(UIImage (named: "send"), for: .normal)
        button.addTarget (self, action: #selector (tappedSendButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func tappedSendButton() {
        let text = messageTextField.text ?? ""
        delegate?.tappedButton(text: text)
        messageTextField.text = ""
        sendButton.isEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backGround
        addSubViews()
        configConstraints()
    }
    
    public func configTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(tableView)
        addSubview(contentView)
        contentView.addSubview(subContentView)
        subContentView.addSubview(messageTextField)
        contentView.addSubview(sendButton)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.topAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 70),
            
            subContentView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            subContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            subContentView.heightAnchor.constraint(equalToConstant: 50),
            
            messageTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            messageTextField.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor, constant: 10),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.trailingAnchor, constant: -5),
            messageTextField.heightAnchor.constraint(equalToConstant: 40),
            
            sendButton.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor, constant: -5),
            sendButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 45),
            sendButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
}
