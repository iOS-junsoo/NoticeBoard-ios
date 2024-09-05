//
//  DetailViewController.swift
//  NoticeBoard
//
//  Created by 준수김 on 9/4/24.
//

import UIKit

class DetailViewController: UIViewController, APIResultDelegate {
    
    var post_id: Int
    var post_title: String
    var post_content: String
    var post_author: String
    var post_comments: [Comment]
    var select: Int
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    private lazy var api: APIDelegate = API()
    init?(coder: NSCoder, id: Int,title: String, content: String, author: String, comments: [Comment], select: Int){
        self.post_id = id
        self.post_title = title
        self.post_content = content
        self.post_author = author
        self.post_comments = comments
        self.select = select
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
            self.post_id = 0
            self.post_title = ""
            self.post_content = ""
            self.post_author = ""
            self.post_comments = []
            self.select = 0
            super.init(coder: coder)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    func getResult(_ result: [Post]) {
        post_comments = result[select].comments
        tableView.reloadData()
    }
    
    func setUpTableView(){
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UINib(nibName: "DetailPostingTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailPostingTableViewCell")
        tableView.register(UINib(nibName: "DetailCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailCommentTableViewCell")
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
        })
    }

    @IBAction func sendBtn(_ sender: Any) {
        
        if authorTextField.text == "" {
            authorTextField.text = "익명"
        }
        
        api.addComment(id: post_id, comment: Compact_Comment(content: commentTextField.text ?? "", author: authorTextField.text ?? ""), completion: {
            self.commentTextField.text = ""
            self.authorTextField.text = ""
            self.tableView.reloadData()
            self.api.getPost(delegate: self)
        })
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post_comments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPostingTableViewCell") as! DetailPostingTableViewCell
            cell.selectionStyle = .none
            cell.title.text = post_title
            cell.content.text = post_content
            cell.author.text = post_author
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCommentTableViewCell") as! DetailCommentTableViewCell
            cell.selectionStyle = .none
            cell.author.text = post_comments[indexPath.row - 1].author
            cell.content.text = post_comments[indexPath.row - 1].content
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 155
        default:
            return 75
        }
    }
}

