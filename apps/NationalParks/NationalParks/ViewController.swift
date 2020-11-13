//
//  ViewController.swift
//  NationalParks
//
//  Created by Sara Reddy on 11/12/20.
//  Copyright © 2020 Sara Reddy. All rights reserved.
//

import UIKit
import Kingfisher

struct Repo: Codable {
    let data: [Park]
    
    struct Park: Codable {
        let name: String
        let description: String
        let designation: String
        let images: [Image]
        
        struct Image: Codable {
            let url: URL
        }
    }
}

class NationalParksTableViewController: UITableViewController {

    var allPark = [Repo.Park]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        tableView.refreshControl = refreshControl
        refreshControl?.addTarget(self, action: #selector(startRefreshing), for: .valueChanged)
        fetchNPSRepos()
    }
    
    @objc func startRefreshing() {
        refreshControl?.beginRefreshing()
        fetchNPSRepos()

    }
    
    private func fetchNPSRepos() {
        guard let url = URL(string: "https://developer.nps.gov/api/v1/parks?api_key=MdUmsIWZXQmT9bliqqcPaOCfUjddlHJc6hP7zARs") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let decodedRepos = try? JSONDecoder().decode(Repo.self, from: data) {
                    self.allPark = decodedRepos.data
                    self.allPark = Array(self.allPark[0...29])
                    
                    DispatchQueue.main.async {
                        self.refreshControl?.endRefreshing()
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailViewController" {
            let index = (sender as? IndexPath)?.row ?? 0
            let detailController = segue.destination as! DetailViewController
            detailController.data = allPark[index]
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let curr = allPark[indexPath.row]
           let cell = tableView.dequeueReusableCell(withIdentifier: "ParkCellView", for: indexPath) as! ParkCell
           
           cell.subtitle?.text = curr.designation
           cell.titleLab?.text = curr.name
           cell.accessoryType = .disclosureIndicator
           cell.parkImageView?.kf.setImage(with: curr.images[0].url)
           return cell
       }
       

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            detailController.data = allPark[indexPath.row]
            navigationController?.pushViewController(detailController, animated: true)
        }
       
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return allPark.count
       }
       
       override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
       
       override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 70.0
       }

}

