//
//  ViewModel.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 05/11/2020.
//

import Foundation

class ViewModel: ObservableObject {
    private var login = AppleIDLogin()
    @Published var user:User?
    
    func appleLogin() {
        login.getAppleRequest()
    }
    
    func getUserInfo() {
        if let userData = UserDefaults.standard.object(forKey: "user") as? Data, let userDecode = try? JSONDecoder().decode(User.self, from: userData) {
            user = userDecode
        }
    }
}
