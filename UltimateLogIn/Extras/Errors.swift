//
//  Error.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 08/11/2020.
//

import Foundation

class Errors {
    
    //Login and LoginMail error titles:
    let LOGIN_ERROR_TITLE = "login_error_title"
    //Login ans LoginMail error messages:
    let EMAIL_NOT_VERIFIED_LOGIN_ERROR_MESSAGE = "email_not_verified_login_error_message"
    let GOOGLE_LOGIN_ERROR_MESSAGE = "google_login_error_message"
    let UNEXPECTED_ERROR_MESSAGE = "unexpected_error_message"
    let EMAIL_USED_ERROR_MESSAGE = "email_used_error_message"
    
    //SignUp error titles:
    let REGISTRATION_ERROR_TITLE = "registration_failure_title"
    let REGISTRATION_SUCCESS_TITLE = "registration_completed_title"
    //SignUp error messages:
    let REGISTRATION_SUCCESS_MESSAGE = "registration_completed_message"
    let DIFFERENT_PASSWORDS_ERROR_MESSAGE = "different_passwords_message"
    let UPLOADING_TO_FIRESTORE_ERROR_MESSAGE = "uploading_to_firestore_error_message"
    let UPLOADING_TO_STORAGE_ERROR_MESSAGE = "uploading_to_storage_error_message"
    
    //Email verification error messages:
    let VERIFICATION_EMAIL_NOT_SENDED_MESSAGE = "verification_email_not_sended_message"
    
    //PassReset error titles:
    let RESET_PASSWORD_ERROR_TITLE = "reset_password_error_title"
    let RESET_PASSWORD_SUCCESS_TILE = "reset_password_success_title"
    //PassReset error messages:
    let RESET_PASS_SUCCESS_MESSAGE = "reset_password_success_message"
    
    //LogOut error titles:
    let LOGOUT_ERROR_TITLE = "Log Out failure"
    
    //Inicio error titles:
    let FIRESTORE_ERROR_TITLE = "firestore_error_title"
    //Inicio error messages:
    let GETTING_FROM_FIRESTORE_ERROR_MESSAGE = "getting_from_firestore_error_message"
    let GETTING_FROM_STORAGE_ERROR_MESSAGE = "getting_from_storage_error_message"
    
    
    //Firebase error messages:
    let NETWORK_ERROR_MESSAGE = "network_error_message"
    let EMAIL_BADLY_FORMATTED_MESSAGE = "email_badly_formatted_message"
    let PASSWORD_FORMAT_ERROR = "password_format_error_message"
    let USER_NOT_EXISTS_ERROR = "user_not_exists_error_message"
    let ORIGINAL_PASSWORD_FORMAT_ERROR = "The password must be 6 characters long or more."
    let ORIGINAL_EMAIL_FORMAT_ERROR = "The email address is badly formatted."
    let ORIGINAL_NETWORK_ERROR = "Network error (such as timeout, interrupted connection or unreachable host) has occurred."
    let ORIGINAL_USER_NOT_EXISTS_ERROR = "There is no user record corresponding to this identifier. The user may have been deleted."
    let ORIGINAL_EMAIL_USED_ERROR = "The password is invalid or the user does not have a password."
}
