//
//  UserdefaultData.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import Foundation

enum UserDefaultsInfo: String {
case selectedCharacterIndexTemporary
case selectedCharacterIndexFixed
case characterMealCount
case characterWaterCount
case userNickname
case isCharacterSelected
}


enum FoodType:CaseIterable {
case meal
case water
}

enum SettingTitle:String, CaseIterable {
case updateMyNickname = "내 이름 설정하기"
case updateCharacter = "다마고치 변경하기"
case resetData = "데이터 초기화"
}

struct SettingValue {
    let title: String
    let image: String
}

struct SettingValues {
    static let settingValues: [SettingValue] = [
        SettingValue(title: SettingTitle.updateMyNickname.rawValue, image: "pencil"),
        SettingValue(title: SettingTitle.updateCharacter.rawValue, image: "moon.fill"),
        SettingValue(title: SettingTitle.resetData.rawValue, image: "arrow.clockwise")
    ]
}
