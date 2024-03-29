//
//  WorkSpaceInitalView.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/01/18.
//

import SwiftUI

struct WorkSpaceInitalView: View {
    @EnvironmentObject var appState: AppState
    @State var showCreateWorkspaceView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 15) {
                    VStack(spacing: 24) {
                        Text("출시 준비 완료!")
                            .font(CustomFont.title1.font)
                        Text("\(appState.userData.nickname)님의 조직을 위해 새로운 새싹톡 워크스페이스를 시작할 준비가 완료되었어요!")
                            .multilineTextAlignment(.center)
                            .font(CustomFont.body.font)
                            .padding([.leading, .trailing], 23)
                    }
                    .padding(.top, 35)
                    
                    Image(.launching)
                        .frame(width: 368)
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                }
                Spacer()
                KeyboardStickeyButton(isFocus: .constant(false), title: "워크스페이스 생성", isEnable: .constant(true)) {
                    showCreateWorkspaceView = true
                }
            }
            .defaultBackground()
            .underlineNavigationBar(title: "시작하기")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        appState.isLoggedIn = true
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                    })
                }
            }
            .sheet(isPresented: $showCreateWorkspaceView, content: {
                WorkspaceInitalizeView(presenting: $showCreateWorkspaceView)
            })
        }
    }
}

#Preview {
    WorkSpaceInitalView()
        .environmentObject(AppState())
}
