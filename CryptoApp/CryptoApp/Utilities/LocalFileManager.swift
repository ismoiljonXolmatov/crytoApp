//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 12.03.2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let shared = LocalFileManager()
    
    private init() {}
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        //generate folder if needed
        generateFolderIfNeeded(folderName: folderName)
        //get url for image
        guard let data = image.pngData(),
        let url = getUrlForImage(imageName: imageName, folderName: folderName) else {
            return
        }
        //save image to path
        do {
            try  data.write(to: url)
        } catch let error {
         debugPrint("Error saving image \(error) at \(folderName)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let urlPath = getUrlForImage(imageName: imageName, folderName: folderName)?.path(),
              FileManager.default.fileExists(atPath: urlPath) else {
            return nil
        }
        return UIImage(contentsOfFile: urlPath)
    }
    
    func getUrlForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    func getUrlForImage(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getUrlForFolder(folderName: folderName) else {
            return nil
        }
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
    
    func generateFolderIfNeeded(folderName: String) {
        guard let folderUrl = getUrlForFolder(folderName: folderName) else {return}
        if !FileManager.default.fileExists(atPath: folderUrl.path()) {
            do {
                try FileManager.default.createDirectory(at: folderUrl, withIntermediateDirectories: true)
            } catch let error {
                print("Error occured while creating a folder at: \(folderUrl)")
            }
        }
        
    }
}
