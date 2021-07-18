//
//  ViewController.swift
//  TestingPlayground
//
//  Created by Дмитрий Тримонов on 18.07.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Fetching"
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        token = model.addListener(self)
        model.fetch()
    }
    
    deinit {
        model.removeListener(token: token)
    }
    
    private let label = UILabel()
    private var token: Model.Token!
    private let model: Model = Model(logger: PrintLogger())
}

extension ViewController: ModelListener {
    func onModelDidUpdate() {
        label.text = "Ready"
    }
}
