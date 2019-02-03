//
//  AdherenceTableViewController.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/2/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import UIKit

class AdherenceTableViewController: UITableViewController {
    
    var viewModel = AdherenceViewModel.empty

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadViewModel()
        tableView.reloadData()
    }
    
    func reloadViewModel() {
        if let currentUser = UserManager.currentUser {
            viewModel = AdherenceViewModel(user: currentUser, friends: UserManager.currentFriends)
        } else {
            viewModel = AdherenceViewModel(me: FriendAdherenceViewModel(name: "Me", streak: 4, actionable: false, dayAdherenceViewModels: [DayAdherenceViewModel(dayString: "2/3", adherence: 0.9)]), friends: [FriendAdherenceViewModel(name: "Jane Shin", streak: 11, actionable: true, dayAdherenceViewModels: [DayAdherenceViewModel(dayString: "2/3", adherence: 0.9)]), FriendAdherenceViewModel(name: "Andrew Wong", streak: 7, actionable: true, dayAdherenceViewModels: [DayAdherenceViewModel(dayString: "2/3", adherence: 0.9)])])
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.hasFriends ? 2 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : (viewModel.friends.count + 1)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 && indexPath.row == viewModel.friends.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendAdherenceTableViewCell
        let cellViewModel = indexPath.section == 0 ? viewModel.me : viewModel.friends[indexPath.row]
        cell.configure(for: cellViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "My Adherence" : "My Friends & Family"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == viewModel.friends.count {
            let alert = UIAlertController(title: "Send Sharing Request", message: "", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "Email"
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                guard let email = alert.textFields?.first?.text else { return }
                
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        let cellViewModel = indexPath.section == 0 ? viewModel.me : viewModel.friends[indexPath.row]
        if !cellViewModel.actionable { return }
        
        let alert = UIAlertController(title: cellViewModel.name, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Start Competition", style: .default, handler: { _ in
            // start competition
        }))
        alert.addAction(UIAlertAction(title: "Stop Sharing", style: .destructive, handler: { _ in
            // stop
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
