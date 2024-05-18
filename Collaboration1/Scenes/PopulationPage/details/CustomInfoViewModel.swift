//
//  CustomInfoViewModel.swift
//  Collaboration1
//
//  Created by ana namgaladze on 17.05.24.
//

import Foundation

protocol CustomInfoViewModelDelegate: AnyObject {
    func didUpdateMessage(_ message: String)
}

final class CustomInfoViewModel {
    weak var delegate: CustomInfoViewModelDelegate?
    var message: String?
    
    init(message: String?) {
        self.message = message
    }
    
    func processMessage() {
        guard let message = message else { return }
        
        let components = message.components(separatedBy: "\n")
        guard components.count >= 2 else { return }
        
        delegate?.didUpdateMessage(message)
    }
}

