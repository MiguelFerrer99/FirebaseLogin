//
//  ErrorView.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 10/11/2020.
//

import SwiftUI

struct ErrorView: View {
    
    @Binding var showAlert:Bool
    @Binding var alertTitle:String
    @Binding var alertMessage:String
    @Binding var backLastWindow:Bool
    
    var body: some View {
        GeometryReader {_ in
            VStack {
                if alertTitle == Errors().LOGIN_ERROR_TITLE {
                    Text("login_error_title")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                } else if alertTitle == Errors().REGISTRATION_ERROR_TITLE {
                    Text("registration_failure_title")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                } else if alertTitle == Errors().REGISTRATION_SUCCESS_TITLE {
                    Text("registration_completed_title")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                } else if alertTitle == Errors().RESET_PASSWORD_ERROR_TITLE {
                    Text("reset_password_error_title")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                } else if alertTitle == Errors().RESET_PASSWORD_SUCCESS_TILE {
                    Text("reset_password_success_title")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                } else if alertTitle == Errors().FIRESTORE_ERROR_TITLE {
                    Text("firestore_error_title")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                Spacer()
                if alertMessage == Errors().GOOGLE_LOGIN_ERROR_MESSAGE {
                    Text("google_login_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().UNEXPECTED_ERROR_MESSAGE {
                    Text("unexpected_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().REGISTRATION_SUCCESS_MESSAGE {
                    Text("registration_completed_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().DIFFERENT_PASSWORDS_ERROR_MESSAGE {
                    Text("different_passwords_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().RESET_PASS_SUCCESS_MESSAGE {
                    Text("reset_password_success_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().NETWORK_ERROR_MESSAGE {
                    Text("network_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().EMAIL_BADLY_FORMATTED_MESSAGE {
                    Text("email_badly_formatted_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().PASSWORD_FORMAT_ERROR {
                    Text("password_format_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().USER_NOT_EXISTS_ERROR {
                    Text("user_not_exists_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().EMAIL_USED_ERROR_MESSAGE {
                    Text("email_used_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().VERIFICATION_EMAIL_NOT_SENDED_MESSAGE {
                    Text("verification_email_not_sended_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().EMAIL_NOT_VERIFIED_LOGIN_ERROR_MESSAGE {
                    Text("email_not_verified_login_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().UPLOADING_TO_FIRESTORE_ERROR_MESSAGE {
                    Text("uploading_to_firestore_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().UPLOADING_TO_STORAGE_ERROR_MESSAGE {
                    Text("uploading_to_storage_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().GETTING_FROM_FIRESTORE_ERROR_MESSAGE {
                    Text("getting_from_firestore_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().GETTING_FROM_STORAGE_ERROR_MESSAGE {
                    Text("getting_from_storage_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                }
                Spacer()
                Button {
                    if (alertTitle == Errors().REGISTRATION_SUCCESS_TITLE) || (alertTitle == Errors().RESET_PASSWORD_SUCCESS_TILE) {
                        showAlert = false
                        backLastWindow.toggle()
                    } else {
                        showAlert = false
                    }
                } label: {
                    Text("OK")
                        .frame(width: UIScreen.main.bounds.width-200, alignment: .center)
                        .padding(.all)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }.padding(.all)
            .frame(width: UIScreen.main.bounds.width/1.3, height: UIScreen.main.bounds.height/3.8, alignment: .center)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.vertical, UIScreen.main.bounds.height/4.5)
            .padding(.horizontal, UIScreen.main.bounds.width/8)
        }.background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(showAlert: .constant(false), alertTitle: .constant(""), alertMessage: .constant(""), backLastWindow: .constant(false))
    }
}
