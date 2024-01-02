//
//  SplashScreenView.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/01/02.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("새싹톡을 사용하면 어디서나 팀을 모을 수 있습니다")
                    .multilineTextAlignment(.center)
                    .padding(.leading)
                    .padding(.trailing)
                    .offset(y: 39)
                    .font(CustomFont.title1.font)
                Spacer()
            }
            Image("onboarding")
                .frame(width: 368, height: 368)
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
            
        }
    }
}

#Preview {
    SplashScreenView()
}
