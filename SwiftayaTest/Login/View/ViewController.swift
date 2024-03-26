//
//  ViewController.swift
//  SwiftayaTest
//
//  Created by A7med Fekry on 26/03/2024.
//

import UIKit
import Combine


class ViewController: UIViewController {

    private var viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.login(username: "kminchelle", password: "0lelplR")
        
        viewModel.$user
            .sink { user in
                if let user = user {
                    print(user)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .sink { error in
                if let error = error {
                    // Handle the error if needed
                    print("Error: \(error.localizedDescription)")
                }
            }
            .store(in: &cancellables)
    }

}

