//
//  HomeViewModel.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/06/23.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func reloadData()
}

class HomeViewModel {
    
    private var messageList: [Message] = []
    private var service: HomeService = HomeService()
    private weak var delegate: HomeViewModelProtocol?
    
    public func delegate(delegate: HomeViewModelProtocol) {
        self.delegate = delegate
    }
    
    public var numberOfRowsInSection: Int {
        return messageList.endIndex
    }
    
    public func loadCurrentMessage(indexPath: IndexPath) -> Message {
        return messageList[indexPath.row]
    }
    
    public func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return messageList[indexPath.row].message.heightWithConstrainedWidth(width: 220, font: UIFont(name: "HelveticaNeue-Medium", size: 16) ?? UIFont()) + 60
    }
    
    public func addMessage(message: String, type: TypeMessage = .user) {
        messageList.insert(Message(message: message.trimmingCharacters(in: .whitespacesAndNewlines), typeMessage: type), at: .zero)
    }
    
    public func fetchMessage(message: String) {
        addMessage(message: message)
        service.sendMessage(text: message) { result in
            switch result {
            case .success(let success):
                self.addMessage(message: success, type: .chatGPT)
            case .failure(let failure):
                self.addMessage(message: failure.localizedDescription, type: .chatGPT)
            }
            self.delegate?.reloadData()
        }
    }
}
