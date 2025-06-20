//
//  ToastMessageView.swift
//  Marvie
//
//  Created by Shekhar Manwar on 20/06/25.
//

import SwiftUI

struct ToastMessageView: View {
    var message: String = ""
    var iconName: String = "info.circle.fill"
    var iconColor: Color = .white

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(iconColor)
            
            Text(message)
                .font(.custom("futura", size: 14))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.6), radius: 2, x: 1, y: 1)
        }
        .frame(height: 20)
        .padding()
        .background(
            LinearGradient(
                colors: [.orange, .black],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(12)
        .shadow(color: Color.blue.opacity(0.4), radius: 10)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ToastMessageView(message: "Password fields don't match")
    }
}
