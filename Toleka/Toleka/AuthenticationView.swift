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
    
    @State private var authFlow: AuthFlow = .register
    @State private var authModel = AuthModel()
    
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
            .colorInvert()
            .padding()

            .overlay(alignment: .bottom, content: {
                Color.accentColor
                    .frame(height: 1)

            })

    
            VStack(spacing: 25) {
                
                if authFlow == .login {
                    Button {
                        
                    } label: {
                        Text("Login")
                            .font(.title3)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(12)
                    }
                    .matchedGeometryEffect(id: "MainCTA", in: animation)
                    
                    Button {
                        withAnimation {
                            authFlow = .register
                        }
                    } label: {
                        Text("Create Account")
                            .font(.title3)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(12)
                    }
                    .matchedGeometryEffect(id: "SecondTCA", in: animation)
                    
                } else {
                    HStack(spacing: 25) {
                        Button {
                            withAnimation {
                                authFlow = .login
                            }
                        } label: {
                            Text("Back To Login!")
                                .font(.title3)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .cornerRadius(12)
                        }
                        .matchedGeometryEffect(id: "MainCTA", in: animation)
                        
                        Button {
                            
                        } label: {
                            Text("Continue")
                                .font(.title3)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .cornerRadius(12)
                        }
                        
                        .matchedGeometryEffect(id: "SecondTCA", in: animation)
                    }
                }
            }
            
            
            Spacer()
            Spacer()
        }
        .padding()
        .background(.black, ignoresSafeAreaEdges: .all)
        .foregroundColor(.white)
    }
    
    struct AuthModel {
        var names = ""
        var phone = ""
        var bottleWeight = ""
        var address = ""
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
