//
//  Login.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 30/10/2020.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct Login: View {
    
    @State private var showGoogleLogin = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @Binding var logueado:Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                LoopingPlayer().edgesIgnoringSafeArea(.all).opacity(0.5)
                VStack {
                    VStack {
                        Image("launchScreenIcon")
                            .resizable()
                            .frame(width: 80, height: 80)
                        Text("login")
                            .font(.title)
                            .bold()
                    }
                    Spacer()
                    VStack {
                        HStack {
                            GoogleLogin(show: self.$showGoogleLogin, logueado: self.$logueado, showAlert: self.$showAlert, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage)
                            //Para añadir AppleID Log In, ir a curso Udemy, clase 234 (Pagar Programa Desarrollador Apple)
                        }.frame(width: UIScreen.main.bounds.width - 40, height: 50)
                        Text("o")
                            .foregroundColor(Color.init("textsInvertedColor"))
                            .padding(.bottom)
                            .padding(.top)
                        NavigationLink(destination: LoginEmail(logueado: self.$logueado)) {
                            Text("continue_email")
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width - 70)
                                .padding(.all)
                                .background(Color.init("loginButtonColor"))
                                .cornerRadius(40)
                                .shadow(color: Color.black, radius: 4, y: 1)
                        }
                    }
                    Spacer()
                }
                if showAlert {
                    ErrorView(showAlert: self.$showAlert, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage, backLastWindow: .constant(false))
                }
            }
        }.accentColor(Color.init("secondaryButtonsColor"))
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(logueado: .constant(false))
    }
}
