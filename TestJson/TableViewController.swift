//
//  TableViewController.swift
//  TestJson
//
//  Created by Lin Cui on 2020-11-13.
//

import UIKit

class TableViewController: UITableViewController {
    
    var students: [Student] = []
    
    @IBOutlet var tableStudent: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let urlString = "http://ejd.songho.ca/ios/students_2020.json"
        guard let url = URL(string: urlString) else {
            print("[ERROR] Cannot create a URL")
            return
        }
        // create a URLSessionDataTask
        // URLSession.shared is a singleton session with default config
        let task = URLSession.shared.dataTask(with: url, completionHandler:
                                                { (data, response, error) in
                                                    // error checking first
                                                    if let error = error {
                                                        print("[ERROR] " + error.localizedDescription)
                                                        return
                                                    }
                                                    guard let data = data else { // verify data second
                                                        print("[ERROR] Data is nil")
                                                        return
                                                    }
                                                    // parse json as an array of students using JSONSerialization
                                                    self.parseJson(data)
                                                    
                                                    // MUST reload tableView in main thread
                                                    DispatchQueue.main.async
                                                    {
                                                        self.tableView.reloadData()
                                                       // self.tableStudent.reloadData()
                                                    }
                                                })
        // MUST call resume() after creating URLSessionDataTask
        task.resume()
    }
    
    
    func parseJson(_ data: Data)
    {
        // parse json as an array [Any] using JSONSerialization
        do
     {
        //        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] {
        //            //json is array of dic
        //            for dict in json {
        //                let firstName = dict["firstName"] ?? ""
        //                let lastName = dict["lastName"] ?? ""
        //                let groupName = dict["groupName"] ?? ""
        //                var student = Student(first:firstName,last: lastName,group: groupName)
        //                students.append(student)
        
        //            }
        //        }
        let json = try JSONSerialization.jsonObject(with:data,
                                                    options:[]) as? [Any] ?? []
        for element in json
        {
            // convert each element to dictionary [String:Any]
            if let dict = element as? [String : Any]
            {
                var student = Student()
                student.firstName = dict["firstName"] as? String ?? ""
                student.lastName = dict["lastName"] as? String ?? ""
                student.groupName = dict["groupName"] as? String ?? ""
                self.students.append(student)
            }
        }
     }
        catch
        {
            print("[ERROR] " + error.localizedDescription)
            return
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
     return 1
    }
    override func tableView(_ tableView: UITableView,
     numberOfRowsInSection section: Int) -> Int
    {
     return students.count
    }
    override func tableView(_ tableView: UITableView,
     cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
     // if you make a cell in storyboard, dequeueReusableCell() is
     // guaranteed to return a cell instance (not null)
     let cell = tableView.dequeueReusableCell(
     withIdentifier: "StudentCell", for: indexPath)
     let index = indexPath.row
     let student = students[index]
     cell.textLabel?.text =
     "\(index+1): \(student.firstName) \(student.lastName) (\(student.groupName))"
     return cell
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
