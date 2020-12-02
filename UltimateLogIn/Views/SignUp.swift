//
//  SignUp.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 31/10/2020.
//

import SwiftUI
import Firebase

struct SignUp: View {
    
    private var disableButton:Bool {
        firstname.isEmpty || lastname.isEmpty || email.isEmpty || pass.isEmpty || confirmedPass.isEmpty
    }
    @State private var firstname = ""
    @State private var editingFirstname = false
    @State private var lastname = ""
    @State private var editingLastname = false
    @State private var email = ""
    @State private var editingEmail = false
    @State private var pass = ""
    @State private var confirmedPass = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showPass = false
    @State private var showConfirmedPass = false
    @Binding var showSignUp:Bool
    
    var body: some View {
        ZStack {
            Color.init("bgColor").edgesIgnoringSafeArea(.all)
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            showSignUp.toggle()
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
                        Text("login")
                            .font(.title)
                            .bold()
                    }
                    Spacer()
                    VStack {
                        HStack(spacing: 0) {
                            TextField("firstname", text: self.$firstname) { (focused) in
                                if focused {
                                    editingFirstname = true
                                } else {
                                    editingFirstname = false
                                }
                            }.frame(height: 21)
                            .padding(.all)
                            .background(Color.init("textsColor").opacity(0.5))
                            .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .textContentType(.oneTimeCode)
                            HStack {
                                if !firstname.isEmpty && editingFirstname {
                                    Button {
                                        firstname = ""
                                    } label: {
                                        Image(systemName: "multiply.circle.fill")
                                            .resizable()
                                            .frame(width: 21, height: 21)
                                            .opacity(0.7)
                                            .foregroundColor(Color.init("textsInvertedColor"))
                                    }.padding(.trailing)
                                }
                            }.frame(width: 21, height: 21)
                            .padding(.all)
                            .background(Color.init("textsColor").opacity(0.5))
                            .cornerRadius(40, corners: [.topRight, .bottomRight])
                        }
                        HStack(spacing: 0) {
                            TextField("lastname", text: self.$lastname) { (focused) in
                                if focused {
                                    editingLastname = true
                                } else {
                                    editingLastname = false
                                }
                            }.frame(height: 21)
                            .padding(.all)
                            .background(Color.init("textsColor").opacity(0.5))
                            .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .textContentType(.oneTimeCode)
                            HStack {
                                if !lastname.isEmpty && editingLastname {
                                    Button {
                                        lastname = ""
                                    } label: {
                                        Image(systemName: "multiply.circle.fill")
                                            .resizable()
                                            .frame(width: 21, height: 21)
                                            .opacity(0.7)
                                            .foregroundColor(Color.init("textsInvertedColor"))
                                    }.padding(.trailing)
                                }
                            }.frame(width: 21, height: 21)
                            .padding(.all)
                            .background(Color.init("textsColor").opacity(0.5))
                            .cornerRadius(40, corners: [.topRight, .bottomRight])
                        }
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
                                    }.padding(.trailing)
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
                        HStack(spacing: 0) {
                            if showConfirmedPass {
                                TextField("confirm_pass", text: self.$confirmedPass)
                                    .frame(height: 21)
                                    .padding(.all)
                                    .background(Color.init("textsColor").opacity(0.5))
                                    .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                    .textContentType(.oneTimeCode)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .textContentType(.oneTimeCode)
                            } else {
                                SecureField("confirm_pass", text: self.$confirmedPass)
                                    .frame(height: 21)
                                    .padding(.all)
                                    .background(Color.init("textsColor").opacity(0.5))
                                    .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                    .textContentType(.oneTimeCode)
                            }
                            HStack {
                                if !confirmedPass.isEmpty {
                                    Button {
                                        showConfirmedPass.toggle()
                                    } label: {
                                        Image(systemName: showConfirmedPass ? "eye.slash.fill" : "eye.fill")
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
                            createUser(user_email: email, user_password: pass)
                        }, label: {
                            Text("sign_up")
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width - 70)
                                .padding(.all)
                                .background(Color.init("loginButtonColor"))
                                .cornerRadius(40)
                                .shadow(color: Color.black, radius: 4, y: 1)
                        }).padding(.top, 7)
                        .disabled(disableButton)
                    }
                    Spacer()
                }
            }.padding(.all)
            if showAlert {
                ErrorView(showAlert: self.$showAlert, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage, backLastWindow: self.$showSignUp)
            }
        }
    }
    
    private func createUser(user_email:String, user_password:String) {
        if pass == confirmedPass {
            Auth.auth().createUser(withEmail: user_email, password: user_password) { (result, error) in
                if result != nil {
                    storeUserDataInFirestore(result: result!)
                    sendVerificationEmail()
                    cleanContents()
                } else {
                    if let error = error {
                        alertTitle = Errors().REGISTRATION_ERROR_TITLE
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
                        alertTitle = Errors().REGISTRATION_ERROR_TITLE
                        alertMessage = Errors().UNEXPECTED_ERROR_MESSAGE
                        showAlert = true
                    }
                }
            }
        } else {
            alertTitle = Errors().REGISTRATION_ERROR_TITLE
            alertMessage = Errors().DIFFERENT_PASSWORDS_ERROR_MESSAGE
            showAlert = true
        }
    }
    private func storeUserDataInFirestore(result: AuthDataResult) {
        let db = Firestore.firestore()
        db.collection("users").document(result.user.uid).setData(["firstname":firstname, "lastname":lastname])
    }
    private func sendVerificationEmail() {
        if Auth.auth().currentUser != nil {
            Auth.auth().currentUser!.sendEmailVerification(completion: { (error) in
                if error == nil {
                    alertTitle = Errors().REGISTRATION_SUCCESS_TITLE
                    alertMessage = Errors().REGISTRATION_SUCCESS_MESSAGE
                    showAlert = true
                } else if error != nil {
                    alertTitle = Errors().REGISTRATION_ERROR_TITLE
                    alertMessage = Errors().VERIFICATION_EMAIL_NOT_SENDED_MESSAGE
                    showAlert = true
                }
            })
        }
    }
    private func cleanContents() {
        firstname = ""
        lastname = ""
        email = ""
        pass = ""
        confirmedPass = ""
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(showSignUp: .constant(true))
    }
}
