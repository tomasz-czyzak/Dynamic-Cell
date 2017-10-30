//
//  DataManager.swift
//  Dynamic Cell
//
//  Created by Tomasz Czyzak on 30/10/2017.
//  Copyright © 2017 TC. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case unknown
    case invalidUrl
    case emptyResponse
    case wrongStatusCode
    case invalidJson
    case noData
}

protocol DataManagerDelegate {
    func requestCompleted(data: [String]?, error: DataManagerError?)
}

class DataManager {
    static func requestData(delegate: DataManagerDelegate) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        sessionConfig.timeoutIntervalForResource = 120
        let session = URLSession(configuration: sessionConfig)

        guard let url = URL(string: "https://private-9fa56-test11507.apiary-mock.com/data") else {
            return
        }

        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error as NSError? {
                print("ERROR:\(error.code):\(error.localizedDescription)")
                delegate.requestCompleted(data: nil, error: .unknown)
                return
            }
            guard let urlResponse = response as? HTTPURLResponse,
                let data = data else {
                    print("ERROR:empty response")
                    delegate.requestCompleted(data: nil, error: .emptyResponse)
                    return
            }

            if urlResponse.statusCode != 200 {
                print("Unexpected status code:\(urlResponse.statusCode)")
                delegate.requestCompleted(data: nil, error: .wrongStatusCode)
                return
            }

            do {
                guard let dataRows = try JSONSerialization.jsonObject(with: data, options: []) as? [String] else {
                    delegate.requestCompleted(data: nil, error: .invalidJson)
                    return
                }
                if dataRows.count == 0 {
                    delegate.requestCompleted(data: nil, error: .noData)
                    return
                }
                delegate.requestCompleted(data: dataRows, error: nil)
            }
            catch {
                print(error)
                delegate.requestCompleted(data: nil, error: .unknown)
                return
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
