//
//  EmptyMemberDMView.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/02/26.
//

import SwiftUI

struct EmptyMemberDMView: View {
    @Binding var showInviteMember: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("워크스페이스에 멤버가 없어요.")
                .font(CustomFont.title1.font)
            Text("새로운 팀원을 초대해보세요.")
                .font(CustomFont.body.font)
            
            RoundedButton(action: {
                showInviteMember = true
            }, label: {
                Text("팀원 초대하기")
            }, backgroundColor: .brandGreen)
        }
        .frame(width: 260)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    EmptyMemberDMView(showInviteMember: .constant(false))
}
