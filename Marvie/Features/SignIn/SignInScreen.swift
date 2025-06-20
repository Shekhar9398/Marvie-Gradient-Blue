//
//  WelcomeScreen.swift
//  Marvie
//
//  Created by Shekhar Manwar on 10/06/25.
//

import SwiftUI
import FirebaseAuth

struct SignInScreen: View {
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    @State private var path = NavigationPath()
    @State private var signUpEmail: String = ""
    
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
    var body: some View {
        ZStack{
            NavigationStack(path: $path) {
                VStack(alignment: .leading, spacing: 32) {
                    
                    Spacer()
                    
                    // Logo Box
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 45, height: 43)
                            .foregroundStyle(AppColor.accentGreen)
                            .shadow(color: AppColor.darkGreen, radius: 4, x: -2, y: 2)
                        Spacer()
                    }
                    
                    // Welcome Text
                    Text("Welcome!")
                        .font(AppFont.boldSF(size: 60))
                        .foregroundStyle(AppColor.white)
                    
                    Text("Sign in to continue")
                        .font(AppFont.regularSF(size: 30))
                        .foregroundStyle(AppColor.gray1)
                    
                    // Email Field
                    VStack(spacing: 8) {
                        HStack {
                            Image("usernameIcon")
                                .resizable()
                                .frame(width: 38, height: 48)
                                .padding(.trailing, 8)
                            
                            ZStack(alignment: .leading) {
                                if userEmail.isEmpty {
                                    Text("john\("@")gmail.com")
                                        .foregroundStyle(AppColor.gray1)
                                        .font(AppFont.mediumSF(size: 25))
                                }
                                
                                TextField("", text: $userEmail)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .font(AppFont.boldSF(size: 25))
                                    .foregroundStyle(AppColor.gray1)
                            }
                        }
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.darkBackground2)
                            .padding(.horizontal, 10)
                    }
                    
                    // Password Field
                    VStack(spacing: 8) {
                        HStack {
                            Image("passwordIcon")
                                .resizable()
                                .frame(width: 38, height: 48)
                                .padding(.trailing, 8)
                            
                            ZStack(alignment: .leading) {
                                if userPassword.isEmpty {
                                    Text("● ● ● ● ● ●")
                                        .foregroundStyle(AppColor.gray1)
                                        .font(AppFont.mediumSF(size: 15))
                                }
                                
                                SecureField("", text: $userPassword)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundStyle(AppColor.gray1)
                            }
                        }
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.darkBackground2)
                            .padding(.horizontal, 10)
                    }
                    
                    // Buttons
                    VStack(alignment: .center, spacing: 20) {
                        Button {
                            signInUser()
                        } label: {
                            Text("Sign In")
                        }
                        .buttonStyle(LongButtonStyle(backgroundColor: AppColor.accentGreen, foregroundColor: AppColor.white, length: 315))
                        
                        Button("Forgot password?", action: {
                            // To be implemented
                        })
                        .font(AppFont.mediumSF(size: 20))
                        .foregroundStyle(AppColor.gray1)
                        
                        Button {
                            path.append("SignUp1")
                        } label: {
                            Text("Create an account")
                        }
                        .buttonStyle(LongButtonStyle(backgroundColor: AppColor.darkGreen, foregroundColor: AppColor.white, length: 315))
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea(.keyboard)
                .navigationDestination(for: String.self) { value in
                    switch value {
                    case "SignUp1":
                        SignUpScreenOne(path: $path, userEmail: $signUpEmail)
                    case "SignUp2":
                        SignUpScreenTwo(path: $path, userEmail: $signUpEmail)
                    case "SignUp3":
                        SignUpScreenThree(path: $path)
                    case "ContentView":
                        ContectView(path: $path)
                    default:
                        EmptyView()
                    }
                }
                
            }
            
            if showToast {
                VStack {
                    Spacer()
                    ToastMessageView(message: toastMessage)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                        .padding()
                }
                .padding(.horizontal)
                .animation(.easeInOut(duration: 0.4), value: showToast)
                .background(Color.clear)
                .allowsHitTesting(false)
            }
        }
    }
    
    private func signInUser() {
        guard !userEmail.isEmpty, !userPassword.isEmpty else {
            toastMessage = "Please enter email and password"
            showToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showToast = false
            }
            return
        }
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { result, error in
            if let error = error {
                toastMessage = error.localizedDescription
                showToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showToast = false
                }
                return
            } else {
                path.append("ContentView")
            }
        }
    }
    
}

#Preview {
    SignInScreen()
}
