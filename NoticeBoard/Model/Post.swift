//
//  Post.swift
//  NoticeBoard
//
//  Created by 준수김 on 9/3/24.
//

import Foundation
struct Post: Codable {
    let id: Int
    let title: String
    let content: String
    let author: String
    let comments: [Comment]
}

struct Compact_Post: Codable {
    let title: String
    let content: String
    let author: String
}

struct PostList: Codable {
    let posts: [Post]
}
