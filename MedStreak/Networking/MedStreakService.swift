//
//  MedStreakService.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/2/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import Alamofire
import Foundation

enum MedStreakServiceError: Error {
    case dataNotFound
    case invalidData
}

extension MedStreakServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dataNotFound:
            return "Data could not be downloaded."
        case .invalidData:
            return "Downloaded data was invalid."
        }
    }
}

struct MedStreakService {
    let api: API
    let decoder: JSONDecoder
    
    let session = SessionManager()
    
    let userID = "5c5683b36ea3a67c56cb48b2"
    
    static let shared = MedStreakService()
    private init() {
        api = API(baseURL: URL(string: "http://hippocratesmedreview.org/")!)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
    }
    
    func deserialize<T: Decodable>(_ type: T.Type, from response: DataResponse<Data>, completion: @escaping (Result<T>) -> Void) {
        guard let data = response.data else {
            completion(.failure(MedStreakServiceError.dataNotFound))
            return
        }
        
        do {
            let decoded = try self.decoder.decode(type, from: data)
            completion(.success(decoded))
        } catch {
            print(response.request?.url ?? "Request URL Unknown", " | ", error)
            completion(.failure(MedStreakServiceError.invalidData))
        }
    }
    
    func getMe(completion: @escaping (Result<User>) -> Void) {
        getUser(withID: userID, completion: completion)
    }
    
    func getUser(withID id: String, completion: @escaping (Result<User>) -> Void) {
        session.request(api.user(withID: id)).responseData(completionHandler: { self.deserialize(User.self, from: $0, completion: completion) })
    }
    
    func getFriends(forUserWithID id: String, completion: @escaping (Result<FriendsResponse>) -> Void) {
        session.request(api.friends(forUserWithID: id)).responseData(completionHandler: { self.deserialize(FriendsResponse.self, from: $0, completion: completion) })
    }
}
