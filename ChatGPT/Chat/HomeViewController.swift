//
//  ViewController.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 31/05/23.
//

import UIKit

class HomeViewController: UIViewController {

    var screen: HomeScreen?
    var viewModel: HomeViewModel = HomeViewModel()
    
    override func loadView() {
        screen = HomeScreen()
        view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addLogoTofavigationBarItem(image: UIImage(named: "Logo_GM") ?? UIImage())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate(delegate: self)
        screen?.configTableView(delegate: self, dataSource: self)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.loadCurrentMessage(indexPath: indexPath)
        
        switch model.typeMessage {
        case .user:
            guard let cell = screen?.tableView.dequeueReusableCell(withIdentifier: OutgoingTextTableViewCell.identefier, for: indexPath) as? OutgoingTextTableViewCell else {
                return UITableViewCell()
            }
            cell.setupCell(message: model.message)
            return cell
        case .chatGPT:
            guard let cell = screen?.tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identefier, for: indexPath) as? IncomingTextMessageTableViewCell else {
                return UITableViewCell()
            }
            cell.setupCell(message: model.message)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
}

extension HomeViewController: HomeScreenProtocol {
    func tappedButton(text: String) {
        
    }
}
