//
//  PostViewController.swift
//  NoticeBoard
//
//  Created by 준수김 on 9/3/24.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var completeBtn: UIButton!
    private lazy var api: APIDelegate = API()
    let descriptionTextPlaceHolder = "내용을 작성해주세요."
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        contentTextView.delegate = self
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func completeBtn(_ sender: Any) {
        
        if titleTextField.text == "" || contentTextView.text == descriptionTextPlaceHolder || contentTextView.text == "" {
            completeBtn.isEnabled = false
        } else {
            completeBtn.isEnabled = true
            if authorTextField.text == "" {
                authorTextField.text = "익명"
            }
            api.addPost(post: Compact_Post(title: titleTextField.text ?? "", content: contentTextView.text ?? "", author: authorTextField.text ?? ""), completion: {
                self.dismiss(animated: true)
                NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
            })
            
        }
        
    }
    
    
    
}
extension PostViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
            if contentTextView.text == descriptionTextPlaceHolder {
                contentTextView.text = nil
                contentTextView.textColor = .systemGray
            }
        }
  
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                contentTextView.text = descriptionTextPlaceHolder
                contentTextView.textColor = .lightGray

            }
        }
    

}
