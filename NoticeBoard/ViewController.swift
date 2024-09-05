//
//  ViewController.swift
//  NoticeBoard
//
//  Created by 준수김 on 9/2/24.
//

import UIKit

class ViewController: UIViewController, APIResultDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    private lazy var api: APIDelegate = API()
    var postList: [Post] = []
    var selected = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        api.getPost(delegate: self)
        setUpTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
    }
    
    @objc func reload() {
        api.getPost(delegate: self)
    }
    
    func getResult(_ result: [Post]) {
        postList = result
        tableView.reloadData()

    }

    func setUpTableView(){
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UINib(nibName: "PostingTableViewCell", bundle: nil), forCellReuseIdentifier: "PostingTableViewCell")
    }
    

    @IBSegueAction func goDetail(_ coder: NSCoder) -> DetailViewController? {
        return DetailViewController(coder: coder, id: postList[selected].id, title: postList[selected].title, content: postList[selected].content, author: postList[selected].author, comments: postList[selected].comments, select: selected)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostingTableViewCell", for: indexPath) as! PostingTableViewCell
        cell.titleLabel.text = postList[indexPath.row].title
        cell.contentLabel.text = postList[indexPath.row].content
        cell.authorLabel.text = "\(postList[indexPath.row].author) | 댓글 \(postList[indexPath.row].comments.count)개"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler) in
            // 삭제 버튼을 눌렀을 때 데이터 삭제 처리
            self.api.deletePost(id: self.postList[indexPath.row].id)
            self.postList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)

        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = indexPath.row
        print("선택\(indexPath.row)")
        performSegue(withIdentifier: "goDetailView", sender: self)
    }
    
}


// 데이터가 안넘어감 
