//
//  SettingsViewModel.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 15/06/23.
//

import UIKit

protocol SettingsViewModelProtocol: AnyObject {
    func success()
    func error(error: ErrorProfile)
}

class SettingsViewModel {
    
    weak var delegate: SettingsViewModelProtocol?
    var service: SettingsService = SettingsService()
    var person: Person?
    
    var getName: String {
        return person?.name ?? ""
    }
    
    var getAge: String {
        return "\(person?.age ?? 0) anos."
    }
    
    public func featchPerson() {
        service.getPersonFromJson { result in
            switch result {
            case .success(let success):
                self.person = success
                self.delegate?.success()
            case .failure(let failure):
                self.delegate?.error(error: failure)
            }
        }
    }
}
