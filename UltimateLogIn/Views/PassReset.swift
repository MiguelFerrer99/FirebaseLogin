//
//  PassReset.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 31/10/2020.
//

import SwiftUI
import Firebase

struct PassReset: View {
    
    private var disableButton:Bool {
        email.isEmpty
    }
    @State private var email = ""
    @State private var editingEmail = false
    @State private var emailEmptyError = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @Binding var showPassReset:Bool
    
    var body: some View {
        ZStack {
            Color.init("bgColor").edgesIgnoringSafeArea(.all)
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            showPassReset.toggle()
                        } label: {
                            Text("cancel")
                                .font(.title3)
                        }.foregroundColor(Color.init("secondaryButtonsColor"))
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    VStack {
                        Image("launchScreenIcon")
                            .resizable()
                            .frame(width: 80, height: 80)
                        Text("reset_password")
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
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .textContentType(.oneTimeCode)
                            .cornerRadius(40, corners: [.topLeft, .bottomLeft])
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
                        Button {
                            resetPassword(user_email: email)
                        } label: {
                            Text("reset_password")
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width - 70)
                                .padding(.all)
                                .background(Color.init("loginButtonColor"))
                                .cornerRadius(40)
                                .shadow(color: Color.black, radius: 4, y: 1)
                        }.padding(.top, 7)
                        .disabled(disableButton)
                    }
                    Spacer()
                    VStack {
                        Button(action: {
                            showPassReset.toggle()
                        }, label: {
                            Text("remember_password")
                        }).foregroundColor(Color.init("secondaryButtonsColor"))
                        .padding(.bottom)
                    }
                    Spacer()
                }
            }.padding(.all)
            if showAlert {
                ErrorView(showAlert: self.$showAlert, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage, backLastWindow: self.$showPassReset)
            }
        }
    }
    
    private func resetPassword(user_email:String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                alertTitle = Errors().RESET_PASSWORD_SUCCESS_TILE
                alertMessage = Errors().RESET_PASS_SUCCESS_MESSAGE
                showAlert = true
            } else {
                if let error = error {
                    alertTitle = Errors().RESET_PASSWORD_SUCCESS_TILE
                    if String(error.localizedDescription) == Errors().ORIGINAL_NETWORK_ERROR {
                        alertMessage = Errors().NETWORK_ERROR_MESSAGE
                    } else if String(error.localizedDescription) == Errors().ORIGINAL_EMAIL_FORMAT_ERROR {
                        alertMessage = Errors().EMAIL_BADLY_FORMATTED_MESSAGE
                    } else if String(error.localizedDescription) == Errors().ORIGINAL_PASSWORD_FORMAT_ERROR {
                        alertMessage = Errors().PASSWORD_FORMAT_ERROR
                    } else if String(error.localizedDescription) == Errors().ORIGINAL_USER_NOT_EXISTS_ERROR {
                        alertMessage = Errors().USER_NOT_EXISTS_ERROR
                    }
                    showAlert = true
                } else {
                    alertTitle = Errors().RESET_PASSWORD_ERROR_TITLE
                    alertMessage = Errors().UNEXPECTED_ERROR_MESSAGE
                    showAlert = true
                }
            }
        }
    }
}

struct PassReset_Previews: PreviewProvider {
    static var previews: some View {
        PassReset(showPassReset: .constant(true))
    }
}
