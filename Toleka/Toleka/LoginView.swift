//
//  LoginView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 21/06/2023.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(spacing: 30) {
            
            Text("App Name")
                .font(.title.weight(.bold))
                .padding(30)
            
            VStack(spacing: 10) {
                Text("Login")
                    .font(.title)
                
                Text("Provide your credentials to login!")
            }
            
            TextField("Phone Number", text: .constant(""))
                .padding()
                .colorInvert()
                .overlay(alignment: .bottom, content: {
                    Color.accentColor
                        .frame(height: 1)
                        .foregroundColor(.red)
                })
            
            VStack(spacing: 20) {
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
                
                Button {
                    
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
            }
            
            
            Spacer()
            Spacer()
        }
        .padding()
        .background(.black, ignoresSafeAreaEdges: .all)
        .foregroundColor(.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
