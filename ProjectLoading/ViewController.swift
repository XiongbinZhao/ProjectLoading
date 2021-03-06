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
        
        let expandingDotLoadingIndicator = ExpandingDotLoadingIndicator(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        expandingDotLoadingIndicator.startAnimating()
        view.addSubview(expandingDotLoadingIndicator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

