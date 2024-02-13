//
//  WorkspaceEditView.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/02/12.
//

import SwiftUI

struct WorkspaceEditView: View {
    
    @Binding var isPresenting: Bool
    @ObservedObject var viewModel: WorkspaceEditViewModel
    
    init(isPresenting: Binding<Bool>, title: String, description: String?, imageData: Data) {
        self._isPresenting = isPresenting
        self.viewModel = SharedAssembler.shared.resolve(WorkspaceEditViewModel.self, argument: title, arg2: description, arg3: imageData)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ImagePickerView(viewModel: viewModel.imageModel)
                    .padding(.bottom, 16)
                    
                    TitleTextField(title: "워크스페이스 이름", isValid: $viewModel.state.isValidTitle, placeHolder: "워크스페이스 이름을 입력하세요 (필수)", kind: .textField, textFieldTitle: $viewModel.title)
                        .padding(.bottom, 24)
                    TitleTextField(title: "워크스페이스 설명", isValid: .constant(true), placeHolder: "워크스페이스를 설명하세요 (옵션)", kind: .textField, textFieldTitle: $viewModel.description)
                    Spacer()
                    
                }
                .padding(24)
                VStack {
                    Spacer()
                        .toastView(toast: $viewModel.state.toast)
                    KeyboardStickeyButton(isFocus: .constant(false), title: "완료", isEnable: .constant(true)) {
                        print(viewModel.imageModel.imageData)
                    }
                }
            }
            .defaultBackground()
            .underlineNavigationBar(title: "워크스페이스 편집")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isPresenting = false
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                    })
                }
            }
            .onReceive(viewModel.$state, perform: { state  in
                isPresenting = !state.successCreateWorkspace
            })
        }
    }
}

#Preview {
    WorkspaceEditView(isPresenting: .constant(true), title: "고양이", description: "귀ㅡ여워", imageData: Data())
}
