//
//  Message.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 09/06/23.
//

import Foundation

enum TypeMessage {
    case user
    case chatGPT
}

struct Message {
    var message: String
    var typeMessage: TypeMessage
}
