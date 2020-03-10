//
//  RandomAvatarGenerator.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/10/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

func getRandomAvatar() -> Data? {
let arrayOfAvatars = ["Hero 6.png, Hero 11.png, Hero 12.png, Hero 13.png, Hero 14.png, Hero 15.png, Hero 16.png, Hero 18.png, Hero 19.png"]

let randomAvatar = arrayOfAvatars.randomElement()

let randomAvatarImageData = Data(randomAvatar!.utf8)
return randomAvatarImageData
}






