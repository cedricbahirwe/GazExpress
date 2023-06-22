//
//  LargeButton.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 22/06/2023.
//

import SwiftUI


struct LargeButton: View {
    let title: LocalizedStringKey
    let radius: CGFloat
    let action: () -> Void
    let state: ButtonState
    
    init(
        _ title: LocalizedStringKey,
        radius: CGFloat = 12,
        state: ButtonState = .enabled,
        action: @escaping () -> Void
    ) {
        
        self.title = title
        self.radius = radius
        self.state = state
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Group {
                if state == .loading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                } else {
                    Text(title)
                }
            }
            .font(.headline)
            .bold()
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(radius)
        }
        .disabled(state != .enabled)
    }
    
    enum ButtonState {
        case enabled, disabled, loading
    }
}
