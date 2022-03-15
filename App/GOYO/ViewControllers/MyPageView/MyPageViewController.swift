//
//  MyPageViewController.swift
//  GOYO
//
//  Created by 짜미 on 2022/02/25.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class MyPageViewController: UIViewController {
    
    // MARK: - Variables
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let email = Auth.auth().currentUser?.email else { return }
        guard let name = Auth.auth().currentUser?.displayName else { return }
        
        print("로그인 된 이메일: \(email)\n로그인 된 이름: \(name)")
        nameLabel.text = name
        emailLabel.text = email
    }
    
    // MARK: - Actions
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        
        if emailLabel.text == "none" {
            canNotSignOut()
        } else {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                self.signOutSuccess()
            } catch let signOutError as NSError {
                print("로그아웃 Error발생:", signOutError)
            }
        }
    }
    
    
    // MARK: - Functions
    
    func canNotSignOut() {
        let cantSignOutLabel = UIAlertController(title: "알림", message: "로그인이 되어있지 않아요\n로그인 후 이용해주세요.", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel)
        
        cantSignOutLabel.addAction(ok)
        
        self.present(cantSignOutLabel, animated: true)
    }
    
    func signOutSuccess() {
        let signOutSuccessLabel = UIAlertController(title: "알림", message: "로그아웃 성공!", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        
        signOutSuccessLabel.addAction(ok)
        
        self.present(signOutSuccessLabel, animated: true)
    }

}
