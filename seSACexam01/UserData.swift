//
//  UserData.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import Foundation

struct CharacterInfo {
    let name:String
    let introduction:String
}

struct CharactersInfo {
    static let characters: [CharacterInfo] = [
        CharacterInfo(name: "따끔따끔 다마고치", introduction: "저는 선인장 다마고치입니다.\n키는 2cm, 몸무게는 150g이에요.\n성격은 소심하지만 마음은 따뜻해요.\n열심히 잘 먹고 잘 클 자신은 있답니다.\n반가워요 주인님!!! "),
        CharacterInfo(name: "방실방실 다마고치", introduction: "저는 방실방실 다마고치입니다.\n키는 100km, 몸무게는 150톤이에용\n성격은 화근하고 날라다닙니당~!\n열심히 잘 먹고 잘 클 자신은 있답니다\n방실방실!"),
        CharacterInfo(name: "반짝반짝 다마고치", introduction: "저는 반짝반짝 다마고치입니다.\n키는 10000km,\n몸무게는 1,500,000톤이에용.\n몸도 마음도 반짝반짝이는 별이에요\n주인님과 함께 빛나고 싶어요!")
    ]
    static let words: [String] = ["1", "2", "3", "4"]
    static let finalWord: String = "고생했다, 이제 알아서 크겠다\n더 이상의 물과 밥은 필요없다"
}

struct UserInfo {
    var level:Int
    var image:String
}
