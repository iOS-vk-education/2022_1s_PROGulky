//
//  ProfileUserInfoHeader.swift
//  PROGulky
//
//  Created by Сергей Киселев on 23.10.2022.
//

import UIKit

final class UserInfoHeader: UIView {
    struct DisplayData {
        let username: String
        let status: String
    }

    // http://37.140.195.167:5000/images/users/

    private let imagePicker = UIImagePickerController()
    var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true

        iv.layer.shadowOpacity = ProfileViewConstants.Header.shadowOpacity
        iv.layer.shadowRadius = ProfileViewConstants.Header.cornerRadius
        iv.layer.cornerRadius = ProfileViewConstants.Header.cornerRadius
        iv.layer.shadowColor = ProfileViewConstants.Header.shadowColor.cgColor

        print("test: \(UserDefaults.standard.string(forKey: UserKeys.image.rawValue))")

//        setupUserImage(with: User)

        guard let image = UserDefaults.standard.string(forKey: UserKeys.image.rawValue) else {
            iv.image = UIImage(systemName: "person.crop.circle")?.withTintColor(.prog.Dynamic.primary, renderingMode: .alwaysOriginal)
            return iv
        }
        let imageUrl = baseURL + "/images/users/" + image
        iv.downloadedFrom(link: imageUrl ?? "")

        return iv
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: UserKeys.name.rawValue)
        label.textColor = .prog.Dynamic.primary
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstantsProfile.titleUserStatus + " - " + (UserDefaults.standard.string(forKey: UserKeys.role.rawValue) ?? "")
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .prog.Dynamic.text
        return label
    }()

    private enum Constants {
        static let offset: CGFloat = 10
        static let imagesSize: CGFloat = 60
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(profileImageView,
                    usernameLabel,
                    statusLabel)
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.imagesSize)
            make.height.equalTo(Constants.imagesSize + 4)
        }

        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(Constants.offset)
            make.centerX.equalToSuperview()
        }

        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(self.usernameLabel.snp.bottom).offset(Constants.offset)
            make.centerX.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ displayData: DisplayData) {
        usernameLabel.text = displayData.username
        statusLabel.text = displayData.status
    }

    private func setupUserImage(with image: String?) {
//        if let image = image {
//            let imageURL = "\(ExcursionsListConstants.Api.ownerImageURL)/\(image)"
//            excursionOwnerImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: "person.fill"))
//        } else {
//            excursionOwnerImage.image = UIImage(systemName: "person.fill")
//        }
    }

    func saveImage(image: UIImage?) {
    }
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
//
//        guard let data = image?.pngData(), let uid = Auth.auth().currentUser?.uid else {
//            return
//        }
//
//        let riversRef = storageRef.child(uid)
//
//        riversRef.putData(data, metadata: nil) { (metadata, error) in
//            guard error == nil else {
//                return
//            }
//            riversRef.downloadURL { (url, error) in
//                guard let downloadURL = url?.absoluteURL, error == nil, let image = image else {
//                    return
//                }
//                let url = "\(downloadURL)"
//                let ref = Database.database().reference().child("users").child(uid)
//                let update = ["height": image.size.height, "url": url, "width": image.size.width] as [String : Any]
//                ref.child("picture").child("data").updateChildValues(update) { (error, ref) in
//                    guard error == nil else {
//                        return
//                    }
//                }
//            }
//        }
}
