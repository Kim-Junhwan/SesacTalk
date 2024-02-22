//
//  DirectMessageTableViewCell.swift
//  ServiceLevelProject
//
//  Created by JunHwan Kim on 2024/02/22.
//

import UIKit

class DirectMessageTableViewCell: UITableViewCell {
    
    static let identifier = "DirectMessageTableViewCell"
    
    private let userProfileImageView: AsyncUIImageView = {
        let asyncImageView = AsyncUIImageView(placeholder: .noPhotoGreen)
        asyncImageView.layer.cornerRadius = 4
        asyncImageView.clipsToBounds = true
        return asyncImageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = CustomFont.body.uifont
        label.textColor = .textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.setContentHuggingPriority(.init(252), for: .horizontal)
        return label
    }()
    
    private let newMessageIcon: PaddingLabel = {
        let label = PaddingLabel(padding: .init(top: 2, left: 6, bottom: 2, right: 6))
        label.font = CustomFont.caption.uifont
        label.textColor = .white
        label.backgroundColor = .brandGreen
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.setContentHuggingPriority(.init(253), for: .horizontal)
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userProfileImageView, titleLabel, newMessageIcon])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        userProfileImageView.fetchImageModel.url = nil
    }

    private func configureView() {
        contentView.addSubview(contentStackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userProfileImageView.widthAnchor.constraint(equalToConstant: 24),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 24),
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func config(profile: String?, name: String, newMessageCount: Int) {
        self.userProfileImageView.fetchImageModel.url = profile
        self.titleLabel.text = name
        userProfileImageView.fetchImageModel.fetchImage()
        newMessageCountLayout(count: newMessageCount)
    }

    private func newMessageCountLayout(count: Int) {
        titleLabel.font = count == 0 ? CustomFont.body.uifont : CustomFont.bodyBold.uifont
        newMessageIcon.text = "\(count)"
        newMessageIcon.isHidden = count == 0
    }
}
