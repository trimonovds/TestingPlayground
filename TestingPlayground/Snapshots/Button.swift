//
//  Button.swift
//  TestingPlayground
//
//  Created by Дмитрий Тримонов on 18.07.2021.
//

import UIKit

class Button: UIButton {
    
    private let loadingView = UIActivityIndicatorView()
    
    public var isLoading: Bool = false {
        didSet {
            isEnabled = !isLoading
            if isLoading { loadingView.startAnimating() }
            else { loadingView.stopAnimating() }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .blue
        layer.cornerRadius = 8
        contentEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
        
        loadingView.color = .white
        addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 24),
            loadingView.widthAnchor.constraint(equalTo: loadingView.heightAnchor)
        ])
    }

    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        super.setTitle("", for: .disabled)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
