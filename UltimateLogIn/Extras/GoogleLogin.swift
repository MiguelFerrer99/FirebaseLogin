//
//  GoogleLogin.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 10/11/2020.
//

import SwiftUI
import GoogleSignIn
import Firebase

struct GoogleLogin: UIViewRepresentable {
    
    @Binding var show:Bool
    @Binding var logueado:Bool
    @Binding var showAlert:Bool
    @Binding var alertTitle:String
    @Binding var alertMessage:String
    
    func makeCoordinator() -> Coordinator {
        return GoogleLogin.Coordinator(conexion: self, logueado: logueado)
    }
    
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .light
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        GIDSignIn.sharedInstance()?.delegate = context.coordinator
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {
        
    }
    
    class Coordinator: NSObject, GIDSignInDelegate {
        
        var conexion:GoogleLogin
        var logueado = false
        
        init(conexion: GoogleLogin, logueado: Bool) {
            self.conexion = conexion
            self.logueado = logueado
        }
        
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            if error != nil {
                self.conexion.alertTitle = Errors().LOGIN_ERROR_TITLE
                self.conexion.alertMessage = Errors().GOOGLE_LOGIN_ERROR_MESSAGE
                self.conexion.showAlert = true
                return
            }
            
            guard let authentication = user.authentication else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { (res, error) in
                if error != nil {
                    print((error?.localizedDescription)!)
                }
                self.conexion.show = true
                self.conexion.logueado = true
                UserDefaults.standard.setValue(true, forKey: "logueado")
                print("Usuario: \(String(describing: res?.user.email))")
            }
        }
    }
}

struct GoogleLogin_Previews: PreviewProvider {
    static var previews: some View {
        GoogleLogin(show: .constant(false), logueado: .constant(false), showAlert: .constant(false), alertTitle: .constant(""), alertMessage: .constant(""))
    }
}
