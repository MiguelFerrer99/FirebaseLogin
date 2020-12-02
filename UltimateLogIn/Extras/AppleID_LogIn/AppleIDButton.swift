//
//  AppleIDButton.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 05/11/2020.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct AppleIDButton:UIViewRepresentable {
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
}

class AppleIDLogin: NSObject, ASAuthorizationControllerDelegate {
    
    func getAppleRequest() {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName,.email]
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.delegate = self
        authController.performRequests()
    }
    
    func userInfo(nombre:String?, email:String?) {
        let user = User(nombre: nombre ?? "Sin nombre", email: email ?? "Sin email")
        if let userEncoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(userEncoded, forKey: "user")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let nombre = (credential.fullName?.givenName ?? "Sin nombre") + " " + (credential.fullName?.familyName ?? "Sin apellido")
            userInfo(nombre: nombre, email: credential.email)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error en AppleID")
    }
}
