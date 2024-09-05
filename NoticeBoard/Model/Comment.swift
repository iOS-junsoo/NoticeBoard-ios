//
//  Comment.swift
//  NoticeBoard
//
//  Created by 준수김 on 9/3/24.
//

import Foundation
struct Comment: Codable {
    let id: Int
    let content: String
    let author: String
}

struct Compact_Comment: Codable {
    let content: String
    let author: String
}
