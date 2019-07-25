//
//  home.swift
//  learn
//
//  Created by Devon Law on 2019-07-23.
//  Copyright © 2019 Slacker. All rights reserved.
//

import Foundation
import UIKit

class home: UIViewController {
    //var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var arrayOfStrings: [String] = []
        scoreLabel.text = "High Score: 0"
        do {
            let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = DocumentDirURL.appendingPathComponent("leaderboard").appendingPathExtension("txt")
            let data = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
            arrayOfStrings = data.components(separatedBy: "\n")
            scoreLabel.text = "High Score: " + arrayOfStrings[0]
        } catch let error as NSError {
            print(error)
        }
    }
}
