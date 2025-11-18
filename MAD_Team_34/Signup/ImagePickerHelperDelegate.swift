//
//  ImagePickerHelperDelegate.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/15/25.
//


import UIKit
import PhotosUI
import AVFoundation

protocol ImagePickerHelperDelegate: AnyObject {
    func imagePickerHelper(_ helper: ImagePickerHelper, didSelect image: UIImage?)
}

class ImagePickerHelper: NSObject {

    weak var delegate: ImagePickerHelperDelegate?

    func openCamera(from vc: UIViewController) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted && UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let picker = UIImagePickerController()
                    picker.sourceType = .camera
                    picker.delegate = self
                    picker.allowsEditing = true
                    vc.present(picker, animated: true)
                } else {
                    self.showSettingsAlert(on: vc, title: "Camera access needed", message: "Please enable camera access in Settings.")
                }
            }
        }
    }

    func openGallery(from vc: UIViewController) {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        let picker = UIImagePickerController()
                        picker.sourceType = .photoLibrary
                        picker.delegate = self
                        picker.allowsEditing = true
                        vc.present(picker, animated: true)
                    } else {
                        self.showSimpleAlert(on: vc, title: "Error", message: "Photo library not available.")
                    }
                default:
                    self.showSettingsAlert(on: vc, title: "Photos access needed", message: "Please enable photo access in Settings.")
                }
            }
        }
    }

    private func showSettingsAlert(on vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        vc.present(alert, animated: true)
    }

    private func showSimpleAlert(on vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }
}

extension ImagePickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        delegate?.imagePickerHelper(self, didSelect: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        let pickedImage = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
        delegate?.imagePickerHelper(self, didSelect: pickedImage)
    }
}
