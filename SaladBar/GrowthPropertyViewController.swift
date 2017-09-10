//
//  GrowthPropertyViewController.swift
//  Salada
//
//  Created by 1amageek on 2017/09/06.
//  Copyright © 2017年 Stamp. All rights reserved.
//

import UIKit
import Firebase

class GrowthPropertyViewController: UIViewController {

    var id: String?

    @IBAction func add(_ sender: Any) {

        guard let id: String = self.id else {
            return
        }
        User.observeSingle(id, eventType: .value) { (user) in
            guard let user: User = user else {
                return
            }
            (0..<1000).forEach { (index) in
                print("Index : \(index)")
                let item: Item = Item()
                item.index = index
                item.save({ (ref, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    user.testItems.insert(item.id)
                })
            }
        }

    }

    @IBAction func create(_ sender: Any) {
        let user: User = User()
        self.id = user.id
        user.name = "growth property"
        user.save { (ref, error) in
            if let error = error {
                print(error)
                return
            }
            (0..<10).forEach { (index) in
                print("Index : \(index)")
                let item: Item = Item()
                item.index = index
                item.save({ (ref, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    user.testItems.insert(item.id)
                })
            }
        }
    }

    @IBAction func observe(_ sender: Any) {

        self.disposer?.dispose()

        guard let id: String = self.id else {
            return
        }

        self.disposer = User.observe(id, eventType: .value) { (user) in
            guard let user: User = user else {
                return
            }
            self.user = user
            self.propertyLabel.text = String(user.testItems.count)
        }

    }

    var user: User?

    var disposer: Disposer<User>?

    @IBOutlet weak var propertyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
