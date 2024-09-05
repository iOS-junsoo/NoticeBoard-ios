//
//  API.swift
//  NoticeBoard
//
//  Created by 준수김 on 9/4/24.
//

import Foundation
import Alamofire

class API: APIDelegate{
    
    private let BASE_URL = "http://192.168.219.106:8080/post"
    
    func getPost(delegate: any APIResultDelegate) {
        AF.request(BASE_URL,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Post].self) { [weak self] response in
                            switch response.result {
                            case .success(let postList):
                                // JSON 데이터가 성공적으로 디코딩되었을 때
                                print("성공 - getPost: \(postList)")
                                delegate.getResult(postList)
                                
                            case .failure(let error):
                                // JSON 데이터 디코딩 실패
                                print("실패 - getPost: \(error)")
                            }
                        }
    }
    
    func addPost(post: Compact_Post, completion: @escaping () -> Void) {
        let parameters: [String: String] = [
                "title": post.title,
                "content": post.content,
                "author": post.author
            ]

        AF.request(BASE_URL,
                    method: .post,
                    parameters: parameters,
                    encoder: JSONParameterEncoder(),
                    headers: ["Content-Type":"application/json; charset=utf-8"] )
            .validate()
            .responseJSON { response in

            switch response.result {
            case .success(let response):
                print("DEBUG>> Success \(response) ")
                completion()
            case .failure(let error):
                print("DEBUG>> Error : \(error.localizedDescription)")
            }

        }
    }
    
    func addComment(id: Int, comment: Compact_Comment, completion: @escaping () -> Void) {
        let URL = BASE_URL + "/\(id)/addComment"
        let parameters: [String: String] = [
                "content": comment.content,
                "author": comment.author
            ]
        
        AF.request(URL,
                    method: .put,
                    parameters: parameters,
                    encoding: JSONEncoding.default,
                    headers: ["Content-Type":"application/json; charset=utf-8"] )
            .validate()
            .responseJSON { response in

            switch response.result {
            case .success(let response):
                print("DEBUG>> Success-comment : \(response) ")
                completion()
            case .failure(let error):
                completion()
            }

        }
    }
    
    func deletePost(id: Int) {
        let URL = BASE_URL + "/\(id)/delete"
        print("delete: \(id)")
        AF.request(URL,
                    method: .delete,
                    parameters: nil,
                    encoding: JSONEncoding.default,
                    headers: ["Content-Type":"application/json; charset=utf-8"] )
            .validate()
            .responseJSON { response in

            switch response.result {
            case .success(let response):
                print("DEBUG>> 삭제 성공, 응답 데이터 없음")
            case .failure(let error):
                print("DEBUG>> 삭제 실패 또는 응답 없음")
            }

        }
    }
    
    
}
