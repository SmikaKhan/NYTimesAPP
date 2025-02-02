//
//  ArticleListTableViewCell.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 31/01/2025.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    // MARK: - UI Components
    private lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = NYTimesColor.articleTitleColor.uiColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = NYTimesColor.subTitleColor.uiColor
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = NYTimesColor.subTitleColor.uiColor
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        contentView.addSubview(articleImageView)
        contentView.addSubview(vStackView)
        
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(authorLabel)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleImageView.widthAnchor.constraint(equalToConstant: 60),
            articleImageView.heightAnchor.constraint(equalToConstant: 60),
            
            vStackView.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 12),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            vStackView.topAnchor.constraint(equalTo: articleImageView.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            dateLabel.topAnchor.constraint(equalTo: vStackView.bottomAnchor, constant: 0),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    var article: Article? {
        didSet {
            if let imageUrl = article?.articlImageUrl {
                articleImageView.loadImage(fromUrl: imageUrl)
            } else {
                articleImageView.image = UIImage(named: "listPlaceHolderImage")
            }
            titleLabel.text = article?.title ?? ""
            authorLabel.text = article?.author ?? ""
            dateLabel.text = article?.publishedDate ?? ""
        }
    }
}



