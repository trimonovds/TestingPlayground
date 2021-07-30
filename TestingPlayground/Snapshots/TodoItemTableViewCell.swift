//
//  TodoItemTableViewCell.swift
//  TestingPlayground
//
//  Created by Дмитрий Тримонов on 30.07.2021.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    
    struct ViewState {
        let title: String
        let image: UIImage
        let titleNumOfLines: Int
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .lightGray
        
        [icon, title].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
        
        icon.setContentHuggingPriority(.required, for: .horizontal)
        icon.setContentCompressionResistancePriority(.required, for: .horizontal)
        title.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(_ viewState: ViewState) {
        self.title.numberOfLines = viewState.titleNumOfLines
        self.title.text = viewState.title
        self.icon.image = viewState.image
    }
    
    private let icon = UIImageView()
    private let title = UILabel()
    
}
