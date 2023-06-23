//
//  AuthenticationView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 21/06/2023.
//

import SwiftUI

struct AuthenticationView: View {
    enum AuthFlow {
        case login, register
    }
    
    @State private var authFlow: AuthFlow = .login
    @State private var authModel = ProfileData()
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    @Binding var navPath: NavigationPath
    
    private var title: LocalizedStringKey {
        authFlow == .login ? "Login" : "Create Account"
    }
    
    private var subtitle: LocalizedStringKey {
        authFlow == .login ? "Provide your credentials to login!" : "Fill the form below to create an account!"
    }
    
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Toleka")
                .font(.largeTitle)
                .fontDesign(.serif)
                .fontWeight(.bold)
                .padding(30)
            
            VStack(spacing: 10) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(subtitle)
            }
            .padding(.bottom)
            
            Group {
                
                if authFlow == .register {
                    TextField("Names", text:$authModel.names)
                        .textContentType(.name)
                }
                
                TextField("Phone Number", text: $authModel.phone)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                
                if authFlow == .register {
                    TextField("(Kgs) weight of the bottle you own", text: $authModel.bottleWeight)
                    
                    TextField("Address (eg: Himbi, Av Du Musee, No. 12)", text: $authModel.address)
                        .textContentType(.fullStreetAddress)
                }
            }
            .padding(.vertical)
            .overlay(alignment: .bottom) {
                Color.accentColor.frame(height: 1)
            }
            
            VStack(spacing: 25) {
                if authFlow == .login {
                    LargeButton("Login") {
                        isLoggedIn = true
                        navPath.append(NavRoute.home)
                    }
                    .matchedGeometryEffect(id: "MainCTA", in: animation)
                    
                    
                    LargeButton("Create Account") {
                        withAnimation {
                            authFlow = .register
                        }
                    }
                    .matchedGeometryEffect(id: "SecondTCA", in: animation)
                    
                } else {
                    HStack(spacing: 25) {
                        LargeButton("Back To Login!") {
                            withAnimation {
                                authFlow = .login
                            }
                        }
                        .matchedGeometryEffect(id: "MainCTA", in: animation)
                        
                        LargeButton("Continue") {
                            
                        }
                        .matchedGeometryEffect(id: "SecondTCA", in: animation)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .toolbar(.hidden)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(navPath: .constant(.init()))
    }
}
