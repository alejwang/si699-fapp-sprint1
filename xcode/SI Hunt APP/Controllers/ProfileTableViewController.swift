//
//  ProfileTableViewController.swift
//  
//
//  Created by Alejandro Wang on 3/25/19.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var userUsernameLabel: UILabel!
    @IBOutlet weak var userHeadlineLabel: UILabel!
    @IBOutlet weak var userInterestLabel: UILabel!
    
    @IBOutlet weak var logoutIncellButton: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileTableViewController.logoutFunction))
        logoutIncellButton.isUserInteractionEnabled = true
        logoutIncellButton.addGestureRecognizer(tap)
        
        getProfileData()
    }
    
    
    @objc func logoutFunction(sender:UITapGestureRecognizer) {
        
        print("> Tapped Log out")
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    // MARK: - Table view data source


    func getProfileData(){
        let APICLIENT_URL = "https://alejwang.pythonanywhere.com/profile/"
        let vc = EventTableViewController(nibName: "EventTableViewController", bundle: nil)
        let username = vc.user_name
        print("> requesting \(APICLIENT_URL) \(String(describing: username))")
        Alamofire.request(APICLIENT_URL + username!, method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                print("Success!Get the data")
                let profileJSON : JSON = JSON(response.result.value!)
                self.updateProfileData(json:profileJSON)
            }
            else{
                print("Error")
            }
        }
    }
    
    func updateProfileData(json: JSON) {
        let username = json["username"].stringValue
        if username != "" {
            userUsernameLabel.text = username
        } else {
            userUsernameLabel.text = "Please log in"
        }
        let headline = json["description"].stringValue
        if headline != "" {
            userHeadlineLabel.text = headline
        } else {
            userHeadlineLabel.text = "..."
        }
        var tags = [String]()
        for tag in json["tags"].arrayValue {
            tags.append(tag.stringValue)
        }
//        print(tags)
        if tags != [] {
            userInterestLabel.text = tags.joined(separator: ", ")
        } else {
            userInterestLabel.text = "0"
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
