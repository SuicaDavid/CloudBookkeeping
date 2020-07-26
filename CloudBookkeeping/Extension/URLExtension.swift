//
//  URLExtension.swift
//  CloudBookkeeping
//
//  Created by Suica on 26/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

extension URL {
    static func formLocalImage(named name: String) -> URL? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path
        
        guard fileManager.fileExists(atPath: path) else {
            guard
                let image = UIImage(named: name),
                let data = image.pngData()
                else { return nil }
            fileManager.createFile(atPath: path, contents: data, attributes: nil)
            return url
        }
        return url
    }
}
