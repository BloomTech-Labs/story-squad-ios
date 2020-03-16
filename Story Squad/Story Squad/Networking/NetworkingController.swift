//
//  NetworkingController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData
import FirebaseFirestore
import UIKit
import Firebase

class NetworkingController {
    
    // MARK: - Properties
    private let baseURL = URL(string: "https://story-squad.herokuapp.com")!
    
    var parentUser: Parent?
    var children: [Child]?
    var child: Child?
    var bearer: Bearer?
    
    // MARK: - Signup Parent Account
    func signupParent(email: String, password: String, termsOfService: Bool, name: String, completion: @escaping(Result<Bearer?, NetworkingError>) -> Void) {
        //        func signupParent(email: String, password: String, termsOfService: Bool,  completion: @escaping(Result<ParentRepresentation?, NetworkingError>) -> Void) {
        
        let headers = [
            "content-type": "application/json",
            "authorization": "Bearer undefined"
        ]
        let json = """
        {
        "email": "\(email)",
        "password": "\(password)",
        "termsOfService": true
        }
        """
        let jsonData = json.data(using: .utf8)
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://story-squad.herokuapp.com/auth/register")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonData!
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(.serverError(error)))
                return
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                // Decode the bearer
                let dataString = String(data: data, encoding: .utf8)
                print("dataString: \(String(describing: dataString))")
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.bearer = bearer
                
                // Create Parent in CoreData
                let temporaryID = UUID().uuidString
                let temporaryPIN = Int16.random(in: 0..<1_000)
                let parent = self.createParent(name: name, id: temporaryID, email: email, password: password, pin: temporaryPIN, context: CoreDataStack.shared.mainContext)
                self.parentUser = parent
                
                //                let parentRepresentation = try JSONDecoder().decode(ParentRepresentation.self, from: data)
                // self.parentUser?.parentRepresentation = parentRepresentation
                //                print("Parent Representation: \(parentRepresentation)")
                //                completion(.success(parentRepresentation))
                
                // Return the Bearer
                completion(.success(bearer))
                return
            } catch {
                print("Error decoding: \(error)")
                completion(.failure(.badDecode))
                return
            }
        })
        dataTask.resume()
    }
    
    //        func signupParent(email: String, password: String, termsOfService: Bool, name: String, completion: @escaping(Result<Bearer?, NetworkingError>) -> Void) {
    
    //          let registerURL = baseURL
    //                .appendingPathComponent("auth")
    //                .appendingPathComponent("register")
    //
    //            let json = """
    //            {
    //            "email": "\(email)",
    //            "password": "\(password)",
    //            "termsOfService": "\(termsOfService)"
    //            }
    //            """
    //
    //            let jsonData = json.data(using: .utf8)
    //
    //            guard let unwrappedData = jsonData else {
    //                print("encoded data wrong, couldn't unwrap data")
    //                completion(.failure(.formattedJSONIncorrectly))
    //                return
    //            }
    //
    //            var request = URLRequest(url: registerURL)
    //            request.httpMethod = HTTPMethod.post.rawValue
    //
    //            request.allHTTPHeaderFields = [
    //              "content-type": "application/json",
    //              "authorization": "Bearer undefined"
    //            ]
    //    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //            request.httpBody = unwrappedData
    //            print("Request: \(request)")
    //
    //            URLSession.shared.dataTask(with: request) { (data, response, error) in
    //
    //                if let error = error {
    //                    print("Error getting response: \(error)")
    //                    completion(.failure(.serverError(error)))
    //                    return
    //                }
    //
    //                if let response = response as? HTTPURLResponse {
    //                    if response.statusCode == 200 {
    //                        print("Good 200 response")
    //                    } else {
    //                        print("Bad response, code: \(response.statusCode)")
    //                        print("\(response)")
    //                        completion(.failure(.unexpectedStatusCode(response.statusCode)))
    //                        return
    //                    }
    //                }
    //
    //                guard let data = data else {
    //                    completion(.failure(.noData))
    //                    return
    //                }
    //                do {
    //                    let dataString = String(data: data, encoding: .utf8)
    //                    print("response Parent data: \(String(describing: dataString))")
    //                    let parentRepresentation = try JSONDecoder().decode(ParentRepresentation.self, from: data)
    ////                    self.parentUser?.parentRepresentation = parentRepresentation
    //                    print("Parent Representation: \(parentRepresentation)")
    //
    //                    let bearer = try JSONDecoder().decode(Bearer.self, from: data)
    //                    self.bearer = bearer
    //                    completion(.success(parentRepresentation))
    //                    return
    //                } catch {
    //                    print("Error decoding: \(error)")
    //                    completion(.failure(.badDecode))
    //                    return
    //                }
    //            }.resume()
    //}
    
    // MARK: - Login Parent Account
    func loginParent(email: String, password: String, completion: @escaping(Result<Bearer?, NetworkingError>) -> Void) {
        
        let registerURL = baseURL
            .appendingPathComponent("auth")
            .appendingPathComponent("login")
        
        var request = URLRequest(url: registerURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        
        let json = """
        {
        "email": "\(email)",
        "password": "\(password)"
        }
        """
        
        let jsonData = json.data(using: .utf8)
        
        guard let unwrappedData = jsonData else {
            print("encoded data wrong, couldn't unwrap data")
            completion(.failure(.formattedJSONIncorrectly))
            return
        }
        request.httpBody = unwrappedData
        print("Request: \(request)")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error getting response: \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("Good 200 response")
                } else {
                    print("Bad response, code: \(response.statusCode)")
                    completion(.failure(.unexpectedStatusCode(response.statusCode)))
                    return
                }
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                // Decoding Bearer
                let dataString = String(data: data, encoding: .utf8)
                print("response Token Data: \(String(describing: dataString))")
                self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
                
                // Fetching Parent from CoreData and setting it as self.ParenUser
                _ = self.fetchParentFromCDWithEmail(email: email)
                
                if self.parentUser == nil {
                    // Create Parent in CoreData
                    let temporaryID = UUID().uuidString
                    let temporaryPIN = Int16.random(in: 0..<1_000)
                    let parent = self.createParent(name: " ", id: temporaryID, email: email, password: password, pin: temporaryPIN, context: CoreDataStack.shared.mainContext)
                    self.parentUser = parent
                }
                
                // Return the Bearer
                completion(.success(self.bearer))
                return
                
            } catch {
                print("Error decoding: \(error)")
                completion(.failure(.badDecode))
                return
            }
        }.resume()
    }
    
    // MARK: - Parent CRUD Methods
    
    // Create Parent
    func createParent(name: String, id: String, email: String, password: String, pin: Int16, context: NSManagedObjectContext) -> Parent? {
        
        let parent = Parent(name: name, id: id, email: email, password: password, pin: pin, context: CoreDataStack.shared.mainContext)
        
        // Saving to CoreData
        CoreDataStack.shared.save(context: context)
        return parent
    }
    
    // Update Parent
    func updateParent(name: String?, id: String, email: String?, pin: Int16?, password: String?, context: NSManagedObjectContext) {
        
        guard let parent = fetchParentFromCD(with: id) else { return }
        
        // Use new property or old property
        let newName = name ?? parent.name
        let newEmail = email ?? parent.email
        let newPin = pin ?? parent.pin
        let newPassword = password ?? parent.password
        
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Parent> = Parent.fetchRequest()
        
        // Array with parent that needs to be fetched
        let parentsByID = [id]
        fetchRequest.predicate = NSPredicate(format: "id IN %@", parentsByID)
        
        // Trying to fetch array of parents
        let fetchedParents = try? moc.fetch(fetchRequest)
        guard let parents = fetchedParents else { return }
        
        for parent in parents {
            
            // Updating Parent
            if parent.id == id {
                parent.name = newName
                parent.email = newEmail
                parent.password = newPassword
                parent.pin = newPin
                
                print("Succefully fetched and updated parent in CoreData")
            } else {
                NSLog("Couldn't fetched and update parent in CoreData")
            }
        }
        
        // Saving to CoreData
        CoreDataStack.shared.save(context: context)
    }
    
    // Delete Parent
    func deleteParentFromCoreData(parent: Parent, context: NSManagedObjectContext) {
        context.performAndWait {
            context.delete(parent)
            CoreDataStack.shared.save(context: context)
        }
    }
    
    // MARK: - Child CRUD Methods
    
    // create Child
    func createChildAndAddToParent(parent: Parent, name: String, username: String?, id: String?, pin: Int16, grade: Int16, cohort: String?, dyslexiaPreference: Bool = false, avatar: String?, context: NSManagedObjectContext) {
        
        // Generate random avatar
        let arrayOfAvatars = ["Hero 6.png", "Hero 11.png", "Hero 12.png", "Hero 13.png", "Hero 14.png", "Hero 15.png", "Hero 16.png", "Hero 18.png", "Hero 19.png"]
        
        let randomAvatar = arrayOfAvatars.randomElement()
        
        // generate random ID
        let temporaryID = UUID().uuidString
        
        //        let randomID = Int16.random(in: 1..<1000)
        
        // swiftlint:disable:next line_length
        let child = Child(name: name, id: temporaryID, username: username, parent: parent, pin: pin, grade: grade, cohort: cohort, dyslexiaPreference: dyslexiaPreference, avatar: randomAvatar, context: context)
        
        // Adding child to it's parent in Core Data
        parent.addToChildren(child)
        CoreDataStack.shared.save(context: context)
    }
    
    // Update Child
    // swiftlint:disable:next function_parameter_count
    func updateChild(name: String?, id: String, username: String?, pin: Int16?, grade: Int16?, cohort: String?, dyslexiaPreference: Bool?, avatar: String?, context: NSManagedObjectContext) {
        
        guard let child = fetchChildFromCD(with: id) else { return }
        
        // Use new property or old property
        let newName = name ?? child.name
        let newUsername = username ?? child.username
        let newPin = pin ?? child.pin
        let newGrade = grade ?? child.grade
        let newCohort = cohort ?? child.cohort
        let newDyslexiaPreference = dyslexiaPreference ?? child.dyslexiaPreference
        let newAvatar = avatar ?? child.avatar
        
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Child> = Child.fetchRequest()
        
        // Array with child that needs to be fetched
        let childrenByID = [id]
        fetchRequest.predicate = NSPredicate(format: "id IN %@", childrenByID)
        
        // Trying to fetch array of children
        let fetchedChildren = try? moc.fetch(fetchRequest)
        
        guard let children = fetchedChildren else { return }
        for child in children {
            
            // Updating Child
            if child.id == id {
                child.name = newName
                child.username = newUsername
                child.pin = newPin
                child.grade = newGrade
                child.cohort = newCohort
                child.dyslexiaPreference = newDyslexiaPreference
                child.avatar = newAvatar
                
                print("Succefully fetched and updated child \(String(describing: name)) in CoreData")
            } else {
                NSLog("Couldn't fetched and update child \(String(describing: name)) in CoreData")
            }
        }
        
        // Saving to CoreData
        CoreDataStack.shared.save(context: context)
    }
    
    // Delete Child
    func deleteChildFromCoreData(child: Child, context: NSManagedObjectContext) {
        
        context.performAndWait {
            context.delete(child)
            CoreDataStack.shared.save(context: context)
        }
    }
    
    // MARK: - Fetch From CoreData
    
    // Parent
    func fetchParentFromCD(with id: String) -> Parent? {
        
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Parent> = Parent.fetchRequest()
        let parentsByID = [id]
        fetchRequest.predicate = NSPredicate(format: "id IN %@", parentsByID)
        
        let possibleParents = try? moc.fetch(fetchRequest)
        
        guard let parents = possibleParents else { return nil }
        for parent in parents {
            
            if parent.id == id {
                self.parentUser = parent
            } else {
                print("Couldn't fetch parent from CoreData")
            }
        }
        return parentUser
    }
    
    func fetchParentFromCDWithEmail(email: String) -> Parent? {
        
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Parent> = Parent.fetchRequest()
        let parentsByEmail = [email]
        fetchRequest.predicate = NSPredicate(format: "email IN %@", parentsByEmail)
        
        let possibleParents = try? moc.fetch(fetchRequest)
        
        guard let parents = possibleParents else { return nil }
        for parent in parents {
            
            if parent.email == email {
                self.parentUser = parent
            } else {
                print("Couldn't fetch parent from CoreData")
            }
        }
        return parentUser
    }
    
    // Child
    func fetchChildFromCD(with id: String) -> Child? {
        
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Child> = Child.fetchRequest()
        let childrenByID = [id]
        fetchRequest.predicate = NSPredicate(format: "id IN %@", childrenByID)
        
        let possibleChildren = try? moc.fetch(fetchRequest)
        
        guard let children = possibleChildren else { return nil }
        for child in children {
            
            if child.id == id {
                self.child = child
            } else {
                print("Couldn't fetch child from CoreData")
            }
        }
        return child
    }
}
