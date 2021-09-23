//
//  WriteTabBarItem.swift
//  FirebaseStorePractice
//
//  Created by yc on 2021/09/23.
//

import UIKit
import FirebaseFirestore

class WriteTabBarItem: UIViewController {
    
    var db = Firestore.firestore()

    @IBOutlet weak var veryGood: UIButton!
    @IBOutlet weak var soso: UIButton!
    @IBOutlet weak var bad: UIButton!
    @IBOutlet weak var dontKnow: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textView: UITextView!
    
    var todayFeel: String?
    var date: String?
    var feelData: FeelData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.todayFeel = "veryGood"
        
        
    }
    
    @IBAction func tapFeelButton(_ sender: UIButton) {
        changeButtonAlpha(sender)
        if sender == self.veryGood {
            self.todayFeel = "veryGood"
        } else if sender == self.soso {
            self.todayFeel = "soso"
        } else if sender == self.bad {
            self.todayFeel = "bad"
        } else if sender == self.dontKnow {
            self.todayFeel = "dontKnow"
        }
    }
    
    private func changeButtonAlpha(_ button: UIButton) {
        self.veryGood.alpha = button == self.veryGood ? 0.3 : 1
        self.soso.alpha = button == self.soso ? 0.3 : 1
        self.bad.alpha = button == self.bad ? 0.3 : 1
        self.dontKnow.alpha = button == self.dontKnow ? 0.3 : 1
    }
    
    @IBAction func tapSaveBarButton(_ sender: UIBarButtonItem) {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        self.date = dateFormatter.string(from: self.datePicker.date)
        
        guard let todayFeel = self.todayFeel,
              let textViewText = self.textView.text,
              let date = self.date else { return }
        
        self.feelData = FeelData(date: date, feel: todayFeel, description: textViewText)
        
        if let feelData = self.feelData {
            db.collection("FeelDataCollections").document(feelData.id).setData([
                "id": feelData.id,
                "date": feelData.date,
                "feel": feelData.feel,
                "description": feelData.description
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
        self.tabBarController?.selectedIndex = 0
    }
    
}
