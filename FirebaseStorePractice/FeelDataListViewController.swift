//
//  FeelDataListViewController.swift
//  FirebaseStorePractice
//
//  Created by yc on 2021/09/23.
//

import UIKit
import FirebaseFirestore

class FeelDataListViewController: UITableViewController {
    var db = Firestore.firestore()

    var feelDataList: [FeelData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("FeelDataCollections").addSnapshotListener { snapshot, error in
            guard let document = snapshot?.documents else { return }
            
            self.feelDataList = document.compactMap { doc -> FeelData? in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let feelData = try JSONDecoder().decode(FeelData.self, from: jsonData)
//                    print("-------------1")
//                    print(feelData)
//                    print("-------------2")
//                    print(self.feelDataList)
//                    print("-------------3")
                    return feelData
                } catch let error {
                    print("여기 에러있습니다. \(error.localizedDescription)")
                    return nil
                }
                

            }.sorted { $0.date > $1.date }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        let nibName = UINib(nibName: "FeelDataTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "FeelDataTableViewCell")
    }
}

extension FeelDataListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feelDataList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeelDataTableViewCell", for: indexPath) as? FeelDataTableViewCell else { return UITableViewCell() }
        
        cell.dateLabel.text = feelDataList[indexPath.row].date
        cell.feelImageView.image = UIImage(named: feelDataList[indexPath.row].feel)
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        detailViewController.descrip = feelDataList[indexPath.row].description
        detailViewController.color = feelDataList[indexPath.row].feel
        detailViewController.date = feelDataList[indexPath.row].date
        
        print(feelDataList[indexPath.row].description)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // 데이터 삭제
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // db에서 삭제
            db.collection("FeelDataCollections").document(feelDataList[indexPath.row].id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                    self.tableView.reloadData()
                }
            }
            
            
            
        }
    }
}
