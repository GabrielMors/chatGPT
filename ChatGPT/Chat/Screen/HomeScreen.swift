//
//  HomeScreen.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 09/06/23.
//

//
//  HomeScreen.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 09/06/23.
//

import UIKit

protocol HomeScreenProtocol: AnyObject {
    func tappedSendButton(text: String)
}

class HomeScreen: UIView {
    
    weak var delegate: HomeScreenProtocol?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .backGround
        tableView.register(OutgoingTextTableViewCell.self, forCellReuseIdentifier: OutgoingTextTableViewCell.identifier)
        tableView.register(IncomingTextMessageTableViewCell.self, forCellReuseIdentifier: IncomingTextMessageTableViewCell.identifier)
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
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
        textField.borderStyle = .none
        textField.placeholder = "Digite aqui:"
        textField.delegate = self
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
        delegate?.tappedSendButton(text: text)
        messageTextField.text = ""
        sendButton.isEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backGround
        addSubViews()
        configConstraints()
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
    
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
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
            subContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            subContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subContentView.heightAnchor.constraint(equalToConstant: 50),
            
            messageTextField.centerYAnchor.constraint(equalTo: subContentView.centerYAnchor),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -5),
            messageTextField.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor, constant: 10),
            messageTextField.heightAnchor.constraint(equalToConstant: 40),
            
            sendButton.heightAnchor.constraint(equalToConstant: 45),
            sendButton.widthAnchor.constraint(equalToConstant: 45),
            sendButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor, constant: -5),
            
        ])
    }
}

extension HomeScreen: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else { return false }
        let updateText = text.replacingCharacters(in: range, with: string)
        if updateText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
        return true
    }
}
