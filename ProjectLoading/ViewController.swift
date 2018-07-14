//
//  ViewController.swift
//  ProjectLoading
//
//  Created by Xiongbin Zhao on 2018-07-09.
//  Copyright © 2018 Xiongbin Zhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loadingIndicator = CircularLoadingIndicator(frame: CGRect(x: 200, y: 200, width: 40, height: 40),
                                                 fromColor: UIColor.black,
                                                 toColor: UIColor.white,
                                                 lineWidth: 2)
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

