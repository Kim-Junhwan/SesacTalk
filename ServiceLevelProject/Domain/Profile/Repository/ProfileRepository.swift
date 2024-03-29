//
//  ProfileRepository.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/02/18.
//

import Foundation

protocol ProfileRepository {
    func fetchMyProfile() async throws -> UserProfile
    func editProfile(_ query: EditProfileQuery) async throws -> UserProfile
    func editProfileImage(imageData: Data) async throws -> UserProfile
    func fetchCoinList() async throws -> [Coin]
    func checkPurchase(_ query: CheckPurchaseQuery) async throws -> PurchaseInfo
}
