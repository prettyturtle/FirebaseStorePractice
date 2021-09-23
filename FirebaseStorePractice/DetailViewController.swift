//
//  DetailViewController.swift
//  FirebaseStorePractice
//
//  Created by yc on 2021/09/23.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelImageView: UIImageView!
    @IBOutlet weak var descriptionBackgroundView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var descrip: String?
    var color: String?
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.descriptionBackgroundView.layer.cornerRadius = 30

        if let description = self.descrip,
           let color = color,
           let date = date {
            
            if color == "veryGood" {
                self.descriptionBackgroundView.backgroundColor = UIColor(red: self.makeColor(254), green: self.makeColor(201), blue: self.makeColor(245), alpha: 1.0)
            } else if color == "soso" {
                self.descriptionBackgroundView.backgroundColor = UIColor(red: self.makeColor(253), green: self.makeColor(254), blue: self.makeColor(194), alpha: 1.0)
            } else if color == "bad" {
                self.descriptionBackgroundView.backgroundColor = UIColor(red: self.makeColor(135), green: self.makeColor(188), blue: self.makeColor(255), alpha: 1.0)
            } else if color == "dontKnow" {
                self.descriptionBackgroundView.backgroundColor = UIColor(red: self.makeColor(192), green: self.makeColor(143), blue: self.makeColor(198), alpha: 1.0)
            }
            
            self.feelImageView.image = UIImage(named: color)
            
            var aa: [String] = []
            aa = date.split(separator: "-").map { String($0) }

            self.dateLabel.text = "\(aa[0])월 \(aa[1])일"
            descriptionLabel.text = description
        }
    }

    private func makeColor(_ colorNumber: Float) -> CGFloat {
        return CGFloat(colorNumber / 255)
    }
}
