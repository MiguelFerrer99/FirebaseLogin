//
//  Inicio.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 29/10/2020.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct Inicio: View {
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showImagePicker = false
    @State private var photoIsSelected = false
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var email = ""
    @State private var userPhoto = UIImage()
    @State private var defaultUserPhoto = UIImage(imageLiteralResourceName: "defaultUserPhoto")
    @Binding var logueado:Bool
    
    var body: some View {
        ZStack {
            Color.init("bgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack {
                    Text("welcome1")
                        .font(.largeTitle)
                        .foregroundColor(Color.init("textsInvertedColor"))
                    Text("welcome2")
                        .font(.largeTitle)
                        .foregroundColor(Color.init("textsInvertedColor"))
                }
                Spacer()
                ZStack {
                    VStack {
                        Button {
                            showImagePicker.toggle()
                        } label: {
                            Image(uiImage: photoIsSelected ? userPhoto : defaultUserPhoto)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipped()
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                .overlay(Circle().stroke(Color.black, lineWidth: 5))
                        }
                    }
                    if photoIsSelected {
                        VStack {
                            Button {
                                photoIsSelected = false
                            } label: {
                                Image("trash")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                            }
                        }.padding(.top,90).padding(.leading,110)
                    }
                }
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("firstname")
                                .font(.title2)
                                .foregroundColor(Color.init("textsInvertedColor"))
                                .opacity(0.5)
                            Text(firstname)
                                .font(.title3)
                                .foregroundColor(Color.init("textsInvertedColor"))
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("lastname")
                                .font(.title2)
                                .foregroundColor(Color.init("textsInvertedColor"))
                                .opacity(0.5)
                            Text(lastname)
                                .font(.title3)
                                .foregroundColor(Color.init("textsInvertedColor"))
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("email")
                                .font(.title2)
                                .foregroundColor(Color.init("textsInvertedColor"))
                                .opacity(0.5)
                            Text(email)
                                .font(.title3)
                                .foregroundColor(Color.init("textsInvertedColor"))
                        }
                        Spacer()
                        Spacer()
                        Spacer()
                    }.padding(.top,10)
                }
                Spacer()
                Button {
                    logOut()
                } label: {
                    Text("logout")
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width - 70)
                        .padding(.all)
                        .background(Color.init("loginButtonColor"))
                        .cornerRadius(40)
                        .shadow(color: Color.black, radius: 4, y: 1)
                }
                Spacer()
            }.sheet(isPresented: self.$showImagePicker) {
                ImagePickerView(isPresented: self.$showImagePicker, selectedImage: self.$userPhoto, photoIsSelected: self.$photoIsSelected).accentColor(Color.init("loginButtonColor"))
            }
            if showAlert {
                ErrorView(showAlert: self.$showAlert, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage, backLastWindow: .constant(false))
            }
        }.onAppear {
            getUserData()
        }
    }
    private func logOut() {
        do {
            try Auth.auth().signOut()
            logueado = false
            UserDefaults.standard.removeObject(forKey: "logueado")
        } catch let error as NSError {
            alertTitle = Errors().LOGOUT_ERROR_TITLE
            alertMessage = String(error.localizedDescription)
            showAlert = true
        }
    }
    private func getUserData() {
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            firstname = (GIDSignIn.sharedInstance()?.currentUser.profile.givenName)!
            lastname = (GIDSignIn.sharedInstance()?.currentUser.profile.familyName)!
            email = (GIDSignIn.sharedInstance()?.currentUser.profile.email)!
        } else if Auth.auth().currentUser != nil {
            email = Auth.auth().currentUser!.email!
            let db = Firestore.firestore()
            db.collection("users").document(Auth.auth().currentUser!.uid).addSnapshotListener { (querySnapshot, error) in
                if error != nil {
                    alertTitle = Errors().FIRESTORE_ERROR_TITLE
                    alertMessage = Errors().GETTING_FROM_FIRESTORE_ERROR_MESSAGE
                    showAlert = true
                } else {
                    let data = querySnapshot!.data()
                    firstname = data!["firstname"] as? String ?? ""
                    lastname = data!["lastname"] as? String ?? ""
                }
            }
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented:Bool
    @Binding var selectedImage:UIImage
    @Binding var photoIsSelected:Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> ImagePickerView.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent:ImagePickerView
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImageFromPicker = info[.originalImage] as? UIImage {
                print(selectedImageFromPicker)
                self.parent.selectedImage = selectedImageFromPicker
                self.parent.photoIsSelected = true
            }
            self.parent.isPresented = false
        }
    }
    
    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
}

struct Inicio_Previews: PreviewProvider {
    static var previews: some View {
        Inicio(logueado: .constant(false))
    }
}
