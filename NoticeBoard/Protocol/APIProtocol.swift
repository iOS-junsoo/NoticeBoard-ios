//
//  APIProtocol.swift
//  NoticeBoard
//
//  Created by 준수김 on 9/4/24.
//

import Foundation

protocol APIDelegate: AnyObject{
    func getPost(delegate: APIResultDelegate)
    func addPost(post: Compact_Post, completion: @escaping () -> Void)
    func addComment(id: Int, comment: Compact_Comment, completion: @escaping () -> Void)
    func deletePost(id: Int)
}

protocol APIResultDelegate {
    func getResult(_ result: [Post])
}
