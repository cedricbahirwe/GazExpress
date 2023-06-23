//
//  ProfileView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 22/06/2023.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var profile: ProfileData
    @Binding var navPath: NavigationPath

    var body: some View {
        VStack {
            Group {
                TextField("Names", text: $profile.names)
                    .textContentType(.name)
                
                TextField("Phone Number", text: $profile.phone)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
            }
            .padding(.vertical)
            .overlay(alignment: .bottom) {
                Color.accentColor.frame(height: 1)
            }
            
            Spacer()
            
            LargeButton("Delete Account", tint: .red) {
                navPath.removeLast(navPath.count)
            }
            
        }
        .padding()
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Logout", role: .destructive) {
                    navPath.removeLast(navPath.count)
                }
                .tint(.red)
            }
        })
        .toolbarBackground(Color.accentColor, for: .navigationBar, .tabBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationTitle("My Account")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView(profile: .init(), navPath: .constant(.init()))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
