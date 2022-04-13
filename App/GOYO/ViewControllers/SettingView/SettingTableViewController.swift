//
//  SettingTableViewController.swift
//  GOYO
//
//  Created by 짜미 on 2022/02/25.
//

import UIKit
import SafariServices

class SettingTableViewController: UITableViewController {

    // MARK: - Variables
    
    
    
    // MARK: - Outlets
    
    @IBOutlet var settingTable: UITableView!
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.settingTable.delegate = self
        self.settingTable.dataSource = self
        
        settingTable.separatorInset.right = 15
        
    }
    
    
    // MARK: - Actions
    
    
    
    // MARK: - Functions
    
    func openGoyoGuide() {
        
        guard let url = URL(string: "https://thin-memory-1d0.notion.site/GOYO-18fe4a9c675d4473ad7d47a35f482db9") else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        
        present(safariViewController, animated: true, completion: nil)
        
    }
    
    func openPrivacyPolicy() {
        
        guard let url = URL(string: "https://thin-memory-1d0.notion.site/GOYO-df8b51e1ac9d4a14ad34549c749d5e0e") else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        
        present(safariViewController, animated: true, completion: nil)
        
    }

    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
        settingTable.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {     // 이용설정 섹션
            if indexPath.row == 0 {     // 주소데이터 삭제 셀
                let locDelete = UIAlertController(title: "주소 데이터를 초기화 하시겠습니까?", message: "신고 주소 리스트가 모두 삭제됩니다.", preferredStyle: UIAlertController.Style.alert)
                let deleteCancel = UIAlertAction(title: "취소", style: UIAlertAction.Style.default)
                let delete = UIAlertAction(title: "삭제", style: UIAlertAction.Style.default) { _ in
                    SelectedLocData.location = []
                    SelectedLocData.saveAllData()
                    
                    self.showOKAlertController(title: "초기화 되었습니다.", message: "", actionTitle: "확인", handler: nil)
                }
                locDelete.addAction(deleteCancel)
                locDelete.addAction(delete)
                self.present(locDelete, animated: true)
            }
        } else {    // 약관 및 정책 섹션
            if indexPath.row == 1 {     // 서비스 이용 안내 셀
                openGoyoGuide()
            } else if indexPath.row == 2 {      // 개인정보 처리방침 셀
                openPrivacyPolicy()
            }
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
