//
//  DrawViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    var networkingController: NetworkingController?
    var parentUser: Parent?
    var childUser: Child?
    
    var imagePicker: ImagePicker!
    
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var chooseFilesFromDeviceButton: UIButton!
    
    @IBOutlet weak var selectedImage1Label: UILabel!
    @IBOutlet weak var selectAnImageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        submitDrawing(child: Child, drawingImage: String, completion: <#T##(Result<String?, NetworkingError>) -> Void#>)
    }
    

    @IBAction func chooseFilesFromDeviceButtonTapped(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    func updateViews() {
       promptLabel.layer.borderWidth = 7.0
        promptLabel.layer.cornerRadius = 10.0
        chooseFilesFromDeviceButton.layer.borderWidth = 3.0
        chooseFilesFromDeviceButton.layer.cornerRadius = 10.0
               submitButton.layer.borderWidth = 3.0
        submitButton.layer.cornerRadius = 10
    }
    
    // MARK: - Submit Drawing
    func submitDrawing(child: Child, drawingImage: String, completion: @escaping(Result<String?, NetworkingError>) -> Void) {
        guard let childBearer = networkingController!.childBearer else {
            completion(Result.failure(NetworkingError.noBearer))
            return
        }
        let registerURL = networkingController!.baseURL
            .appendingPathComponent("illustrationRoutes")
        let json = """
        {
        "illustration": "\(drawingImage)"
        }
        """
        let jsonData = json.data(using: .utf8)
        guard let unwrappedData = jsonData else {
            print("encoded data wrong, couldn't unwrap data")
            completion(.failure(.formattedJSONIncorrectly))
            return
        }
        var request = URLRequest(url: registerURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: HeaderNames.contentType.rawValue)
        request.setValue("\(childBearer.token)", forHTTPHeaderField: HeaderNames.authorization.rawValue)
        request.httpBody = unwrappedData
        print("Request: \(request)")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error getting response: \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 || response.statusCode == 201 {
                    print("Good response")
                    completion(.success("Succesfully Submitted Story"))
                    return
                } else {
                    print("Bad response, code: \(response.statusCode)")
                    completion(.failure(.unexpectedStatusCode(response.statusCode)))
                    return
                }
            }
            guard data != nil else {
                completion(.failure(.noData))
                return
            }
            // TODO: Make a CoreDataModel for the drawing if you need to save it for future displaying porpuses
            // Then decode the Image response here
        }.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension DrawViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        let imageString = image?.description
        selectedImage1Label.text = imageString
    }
}
