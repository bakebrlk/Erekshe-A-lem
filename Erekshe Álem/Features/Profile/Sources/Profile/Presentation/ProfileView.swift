//
//  Profile
//  ProfileView.swift
//
//  Template created by bakebrlk.
//  File created by bakebrlk on 09.02.2026.
//  We'll make it work, and I believe you 🚀
//

import SwiftUI
import CommonUI
import DesignSystem

public struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel
    
    public init(dependencies: Dependencies) {
        _viewModel = StateObject(
            wrappedValue: ProfileViewModel(
                dependencies: .init(coordinator: dependencies.coordinator)
            )
        )
    }

    public var body: some View {
        displayBody
    }

    private var displayBody: some View {
        ZStack {
            Image(.mainBG)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            HStack(spacing: 20) {
                Image(.dolphinProfile)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        maxWidth: UIScreen.main.bounds.width * 0.3,
                        maxHeight: UIScreen.main.bounds.height * 0.8
                    )
                Spacer()
                
                VStack(spacing: 10) {
                    Text("Личные данные")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.blue46D)
                    
                    info(imageName: .mail, text: "bakebrlk@gmail.com")
                    info(imageName: .coin, text: "100")
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 5) {
                            Text("Магазин")
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 17, weight: .black))
                                .foregroundStyle(.white)
                                .padding(.leading, 45)
                            
                            Image(.arrowRight)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 8, maxHeight: .infinity)
                                .padding(.trailing, 10)
                        }
                        .background(
                            Image(.shop)
                                .resizable()
                                .scaledToFit()
                        )
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .cornerRadius(60, corners: .allCorners)

                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("Выйти из аккаунта")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 16, weight: .black))
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 9)
                    .frame(maxWidth: .infinity)
                    .background(.orangeA00)
                    .cornerRadius(70, corners: .allCorners)
                }
                .padding(30)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.41)
                .background(.blue1FF)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.blue3FF, lineWidth: 8)
                )
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 120)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
    
    private func info(imageName: ImageNames, text: String) -> some View {
        HStack(spacing: 5) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 25, maxHeight: 25)
            
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.blueE7B)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(20, corners: .allCorners)
    }
}

extension ProfileView {
    public struct Dependencies {
        
        var coordinator: ProfileCoordinator
        
        public init(
            coordinator: ProfileCoordinator
        ) {
            self.coordinator = coordinator
        }
    }
}
