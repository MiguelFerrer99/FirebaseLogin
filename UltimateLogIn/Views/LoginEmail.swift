//
//  LoginEmail.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 30/10/2020.
//

import SwiftUI
import Firebase

struct LoginEmail: View {
    
    private var disableButton:Bool {
        email.isEmpty || pass.isEmpty
    }
    @State private var email = ""
    @State private var editingEmail = false
    @State private var pass = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var remindUser = false
    @State private var showSignUp = false
    @State private var showPassReset = false
    @State private var showPass = false
    @Binding var logueado:Bool
    
    var body: some View {
        ZStack {
            Color.init("bgColor").edgesIgnoringSafeArea(.all)
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
                    HStack(spacing: 0) {
                        TextField("email", text: self.$email) { (focused) in
                            if focused {
                                editingEmail = true
                            } else {
                                editingEmail = false
                            }
                        }.frame(height: 21)
                        .padding(.all)
                        .background(Color.init("textsColor").opacity(0.5))
                        .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .textContentType(.oneTimeCode)
                        HStack {
                            if !email.isEmpty && editingEmail {
                                Button {
                                    email = ""
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .resizable()
                                        .frame(width: 21, height: 21)
                                        .opacity(0.7)
                                        .foregroundColor(Color.init("textsInvertedColor"))
                                }
                            }
                        }.frame(width: 21, height: 21)
                        .padding(.all)
                        .background(Color.init("textsColor").opacity(0.5))
                        .cornerRadius(40, corners: [.topRight, .bottomRight])
                    }
                    HStack(spacing: 0) {
                        if showPass {
                            TextField("pass", text: self.$pass)
                                .frame(height: 21)
                                .padding(.all)
                                .background(Color.init("textsColor").opacity(0.5))
                                .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                .textContentType(.oneTimeCode)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .textContentType(.oneTimeCode)
                        } else {
                            SecureField("pass", text: self.$pass)
                                .frame(height: 21)
                                .padding(.all)
                                .background(Color.init("textsColor").opacity(0.5))
                                .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                .textContentType(.oneTimeCode)
                        }
                        HStack {
                            if !pass.isEmpty {
                                Button {
                                    showPass.toggle()
                                } label: {
                                    Image(systemName: showPass ? "eye.slash.fill" : "eye.fill")
                                        .frame(width: 21, height: 21)
                                        .foregroundColor(Color.init("textsInvertedColor"))
                                        .opacity(0.7)
                                }
                            }
                        }.frame(width: 21, height: 21)
                        .padding(.all)
                        .background(Color.init("textsColor").opacity(0.5))
                        .cornerRadius(40, corners: [.topRight, .bottomRight])
                    }
                    Button(action: {
                        logIn(userEmail: email, userPassword: pass)
                    }, label: {
                        Text("login")
                            .foregroundColor(.black)
                            .frame(width: UIScreen.main.bounds.width - 70)
                            .padding(.all)
                            .background(Color.init("loginButtonColor"))
                            .cornerRadius(40)
                            .shadow(color: Color.black, radius: 4, y: 1)
                    }).padding(.top, 7)
                    .disabled(disableButton)
                    Toggle(isOn: self.$remindUser, label: {
                        Text("remind_user")
                    }).padding(.top).padding(.leading)
                    .toggleStyle(CheckboxStyle())
                }
                Spacer()
                VStack {
                    Button(action: {
                        showSignUp.toggle()
                    }, label: {
                        Text("go_sign_up")
                    }).foregroundColor(Color.init("secondaryButtonsColor"))
                    .sheet(isPresented: self.$showSignUp, content: {
                        SignUp(showSignUp: self.$showSignUp)
                    }).padding(.bottom)
                    Button(action: {
                        showPassReset.toggle()
                    }, label: {
                        Text("forgot_pass")
                    }).foregroundColor(Color.init("secondaryButtonsColor"))
                    .sheet(isPresented: self.$showPassReset, content: {
                        PassReset(showPassReset: self.$showPassReset)
                    })
                }
                Spacer()
            }.padding(.all)
            if showAlert {
                ErrorView(showAlert: self.$showAlert, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage, backLastWindow: .constant(false))
            }
        }
    }
    
    private func logIn(userEmail:String, userPassword:String) {
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if user != nil {
                if (Auth.auth().currentUser?.isEmailVerified)! {
                    logueado = true
                    if remindUser {
                        UserDefaults.standard.setValue(true, forKey: "logueado")
                    }
                } else {
                    alertTitle = Errors().LOGIN_ERROR_TITLE
                    alertMessage = Errors().EMAIL_NOT_VERIFIED_LOGIN_ERROR_MESSAGE
                    showAlert = true
                }
            } else {
                if let error = error {
                    alertTitle = Errors().LOGIN_ERROR_TITLE
                    if String(error.localizedDescription) == Errors().ORIGINAL_NETWORK_ERROR {
                        alertMessage = Errors().NETWORK_ERROR_MESSAGE
                    } else if String(error.localizedDescription) == Errors().ORIGINAL_EMAIL_FORMAT_ERROR {
                        alertMessage = Errors().EMAIL_BADLY_FORMATTED_MESSAGE
                    } else if String(error.localizedDescription) == Errors().ORIGINAL_PASSWORD_FORMAT_ERROR {
                        alertMessage = Errors().PASSWORD_FORMAT_ERROR
                    } else if String(error.localizedDescription) == Errors().ORIGINAL_USER_NOT_EXISTS_ERROR {
                        alertMessage = Errors().USER_NOT_EXISTS_ERROR
                    } else if String(error.localizedDescription) == Errors().ORIGINAL_EMAIL_USED_ERROR {
                        alertMessage = Errors().EMAIL_USED_ERROR_MESSAGE
                    }
                    showAlert = true
                } else {
                    alertTitle = Errors().LOGIN_ERROR_TITLE
                    alertMessage = Errors().UNEXPECTED_ERROR_MESSAGE
                    showAlert = true
                }
            }
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct LoginEmail_Previews: PreviewProvider {
    static var previews: some View {
        LoginEmail(logueado: .constant(false))
    }
}
