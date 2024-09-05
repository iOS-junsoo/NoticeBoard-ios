//
//  example_detailView.swift
//  NoticeBoard
//
//  Created by 준수김 on 9/3/24.
//
//
//  SeachViewController.swift
//  NoticeBoard
//
//  Created by 준수김 on 9/3/24.
//

//import UIKit
//
//class SeachViewController: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//    var commentList: [Comment] = []
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUpTableView()
//    }
//    
//    func setUpTableView(){
//        tableView.delegate = self;
//        tableView.dataSource = self;
//        tableView.register(UINib(nibName: "DetailPostingTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailPostingTableViewCell")
//        tableView.register(UINib(nibName: "DetailCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailCommentTableViewCell")
//    }
//
//
//}
//
//
//extension SeachViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return commentList.count + 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPostingTableViewCell") as! DetailPostingTableViewCell
//            cell.selectionStyle = .none
//            return cell
//        default:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCommentTableViewCell") as! DetailCommentTableViewCell
//            cell.selectionStyle = .none
//            return cell
//
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler) in
//            // 삭제 버튼을 눌렀을 때 데이터 삭제 처리
//            
//            self.postList.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            completionHandler(true)
//
//        }
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//        configuration.performsFirstActionWithFullSwipe = true
//        return configuration
//    }
//    
//}
