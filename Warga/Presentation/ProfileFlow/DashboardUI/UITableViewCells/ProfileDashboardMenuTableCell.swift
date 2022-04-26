//
//  ProfileDashboardMenuTableCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//

import UIKit

public protocol ProfileDashboardMenuTableCellDelegate: AnyObject {
    func profileDashboardMenuCell(_ cell: ProfileDashboardMenuTableCell, switchValueDidChange switchButton: UISwitch)
}

public final class ProfileDashboardMenuTableCell: UITableViewCell {

    static let reuseIdentifier: String = String(describing: ProfileDashboardMenuTableCell.self)
    
    weak var delegate: ProfileDashboardMenuTableCellDelegate?
    
    var data: ProfileDashboardMenu?
    
    // MARK: - SubViews
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .latoBold(withSize: 16)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    lazy var switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.onTintColor = .primaryPurple
        return switchButton
    }()

    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellDidInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.switchButton.isHidden = true
        self.backgroundImageView.image = nil
        self.backgroundImageView.isHidden = true
        self.titleLabel.text = nil
        self.iconImageView.image = nil
    }
    
    public func configureCell(with data: ProfileDashboardMenu) {
        self.data = data
        self.titleLabel.text = data.title
        self.backgroundColor = data.backgroundColor
        switch data.accessoryType {
        case .disclosureIndicator:
            self.accessoryImageView.image = .chevronRight.withTintColor(.lightGray)
            self.switchButton.isHidden = true
            self.accessoryImageView.isHidden = false
            self.titleLabel.snp.remakeConstraints {
                $0.leading.equalTo(self.iconImageView.snp.trailing).offset(14)
                $0.top.bottom.equalToSuperview().inset(10)
                $0.trailing.equalTo(self.accessoryImageView.snp.leading).offset(-10)
            }
        case .switchButton(let isOn):
            self.switchButton.isOn = isOn
            self.switchButton.isHidden = false
            self.accessoryImageView.isHidden = true
            self.titleLabel.snp.remakeConstraints {
                $0.leading.equalTo(self.iconImageView.snp.trailing).offset(14)
                $0.top.bottom.equalToSuperview().inset(10)
                $0.trailing.equalTo(self.switchButton.snp.leading).offset(-10)
            }
        default:
            self.switchButton.isHidden = true
            self.accessoryImageView.isHidden = true
            self.titleLabel.snp.remakeConstraints {
                $0.leading.equalTo(self.iconImageView.snp.trailing).offset(14)
                $0.top.bottom.equalToSuperview().inset(10)
                $0.trailing.equalToSuperview().inset(24)
            }
        }
        if let backgroundImage = data.backgroundImage {
            self.titleLabel.textColor = .white
            self.backgroundImageView.isHidden = false
            self.backgroundImageView.image = backgroundImage
        }
        self.iconImageView.image = data.iconImage
        switch data.type {
        case .signOut:
            self.titleLabel.textColor = .white
        default:
            self.titleLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: data.backgroundColor, isFlat: true)
        }

    }

}

private extension ProfileDashboardMenuTableCell {
    
    func cellDidInit() {
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.addSubViews()
        self.subViewsMakeConstraints()
        self.switchButton.addTarget(self, action: #selector(self.onSwitchButtonValueChanged(_:)), for: .valueChanged)
    }
    
    func addSubViews() {
        self.dropShadow(offset: CGSize(width: 0, height: 0), opacity: 0.35)
        self.contentView.addSubview(self.backgroundImageView)
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.switchButton)
        self.contentView.addSubview(self.accessoryImageView)
    }
    
    func subViewsMakeConstraints() {
        self.iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self.iconImageView.snp.trailing).offset(14)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.trailing.equalTo(self.switchButton.snp.leading).offset(-10)
        }
        self.backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.switchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        self.accessoryImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
    }
    
    @objc
    func onSwitchButtonValueChanged(_ sender: UISwitch) {
        self.delegate?.profileDashboardMenuCell(self, switchValueDidChange: sender)
    }
    
    
}
