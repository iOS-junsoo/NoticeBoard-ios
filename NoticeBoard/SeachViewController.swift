//
//  SeachViewController.swift
//  NoticeBoard
//
//  Created by 준수김 on 9/3/24.
//

import UIKit

class SeachViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var postList: [Post] = [Post(id: 3, title: "안녕22222", content: "안녕하세용ㅇㅇㅇㅇㅇㅇㅇㅇ", author: "상현"),Post(id: 3, title: "안녕22222", content: "안녕하세용ㅇㅇㅇㅇㅇㅇㅇㅇ", author: "상현")]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    func setUpTableView(){
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UINib(nibName: "PostingTableViewCell", bundle: nil), forCellReuseIdentifier: "PostingTableViewCell")
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    

}


extension SeachViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostingTableViewCell", for: indexPath) as! PostingTableViewCell
        cell.titleLabel.text = postList[indexPath.row].title
        cell.contentLabel.text = postList[indexPath.row].content
        cell.authorLabel.text = postList[indexPath.row].author
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler) in
            // 삭제 버튼을 눌렀을 때 데이터 삭제 처리
            
            self.postList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)

        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
}
