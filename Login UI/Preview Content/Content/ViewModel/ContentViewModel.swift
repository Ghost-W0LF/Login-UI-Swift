//
//  HomeviewModel.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/17/24.
//

import Foundation
import Alamofire
import Security

extension ContentView{
    @Observable
    class ViewModel: ObservableObject {
        var email = "Abhinab1221@gmail.com"
        var password = "werqwerwe"
        var responseModel: LoginResponse?

        
        let session = Session(interceptor: CustomInterceptor())
        let baseUrl = "https://tbe.thuprai.com/v1/api/login/"
        
        func retrivePassword ()  {
            
            // Assuming the KeychainManager class is defined as above
                do {
                    let email = try KeychainManager.retriveData(email: self.email)
                    // Process the retrieved credit card data
                    // For example, you can convert the data to a string or decode it as needed
                    if let emailInfo = String(data: email, encoding: .utf8) {
                        print("Your Password: \(emailInfo)")
                    } else {
                        print("Failed to convert credit card data to a string.")
                    }
                } catch KeychainManager.KeychainRetriveError.itemNotFound {
                    print("Credit card item not found in Keychain.")
                } catch KeychainManager.KeychainRetriveError.unexpectedDataFormat {
                    print("Unexpected data format retrieved from Keychain.")
                } catch KeychainManager.KeychainRetriveError.unknown(let status) {
                    print("Unknown error occurred: \(status)")
                } catch {
                    print("Unexpected error: \(error)")
                }
        }
        func updatePassword ()  {
            
            do{
                try KeychainManager.updateAccessToken(newPassword: password, email: self.email)
                print("Password Updated successfully.")
                print("\(self.password)")
                print("\(self.email)")
            }catch KeychainManager.KeychainUpdateError.itemNotFound{
                print("item error: The password not exists in Keychain.")
            }catch KeychainManager.KeychainUpdateError.unknown(let status){
                print(" Update Unknown error: \(status)")
                
            }catch {
                print("Unexpected error: \(error)")
            }
        }
        
        func loginRequest() {
            
            let credential = LoginRequest(password: password, username: email)
            
            session.request(baseUrl, method: .post, parameters: credential, encoder: JSONParameterEncoder.default)
                .responseDecodable(of: LoginResponse.self) { response in
                    switch response.result{
                    case.success(let data):
                        DispatchQueue.main.async{
                            self.responseModel = data
                        }
                        do {
                            try KeychainManager.storePassword(password: self.password,email: self.email)
                            print("Password stored successfully.")
                            print("\(self.password)")
                            print("\(self.email)")
                        } catch KeychainManager.KeychainError.duplicateItem {
                            print("Duplicate item error: The password already exists in Keychain.")
                        } catch KeychainManager.KeychainError.unknown(let status) {
                            print("Add Unknown error: \(status)")
                        } catch {
                            print("Unexpected error: \(error)")
                        }
                        debugPrint("Token . Data:\(data.token)")
                    case.failure(let error):
                        debugPrint("\(error)")
                    }
            
                    
                }
        }
        
        
        
   
                 
    }
}
