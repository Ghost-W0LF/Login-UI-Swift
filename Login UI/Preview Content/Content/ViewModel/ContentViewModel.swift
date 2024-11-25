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
        
        var email:String  = "Abhinab1221@gmail.com"
         var password = "akkhatri"
        var responseModel: LoginResponse?
        var isShowingIncorectPassword = false
        let session = Session(interceptor: CustomInterceptor())
        let baseUrl = "https://tbe.thuprai.com/v1/api/login/"
        
          var tokenData : String = ""
        
        func loginRequest() {
            
            let credential = LoginRequest(password: password, username: email)
            
            session.request(baseUrl, method: .post, parameters: credential, encoder: JSONParameterEncoder.default)
                .responseDecodable(of: LoginResponse.self) { response in
                    switch response.result{
                    case.success(let data):
                        DispatchQueue.main.async{
                            self.responseModel = data
                            self.tokenData = data.token
                        }
                        let token = data.token
                        // Store token
                        do{
                            try KeychainManager.storePassword(password: token ,email: "token")
                            print("Token stored successfully.")
                        }catch {
                            print("Unexpected error: \(error)")
                        }
                        // Store password
                        
//                        do {
//                            try KeychainManager.storePassword(password: self.password,email: self.email)
//                            print("Password stored successfully.")
//                            print("\(self.password)")
//                            print("\(self.email)")
//                        } catch KeychainManager.KeychainError.duplicateItem {
//                            print("Duplicate item error: The password already exists in Keychain.")
//                        } catch KeychainManager.KeychainError.unknown(let status) {
//                            print("Add Unknown error: \(status)")
//                        } catch {
//                            print("Unexpected error: \(error)")
//                        }

                    case.failure(let error):
                        if response.response?.statusCode == 400 {
                            self.isShowingIncorectPassword = true
                            
                        }else{
                            debugPrint("\(error)")
                        }
                    }
                    
                    
                }
        }
        
        
         func validation() -> Bool {
            return email.count<5 ||  password.count<5 || !email.contains("@")
        }
          func retriveToken ()  {
              
              do {
                  let token = try KeychainManager.retriveData(email: "token")
                  debugPrint("token:\(token)")
                  // Process the retrieved credit card data
                  // For example, you can convert the data to a string or decode it as needed
                  if let tokenInfo = String(data: token, encoding: .utf8) {
                    
                      print("Your token: \(tokenInfo)")
                      tokenData.self = tokenInfo
                      
                  
                  } else {
                      print("Failed to convert credit card data to a string.")
                  }
              
              }catch{
                  print(error)
                  
              }
          }
        func deleteValue() {
            do{
                try KeychainManager.deleteItem(keyPair: "token")
                debugPrint("Token deleted ")
            }catch{debugPrint(error)}
        }
        

        
        func retrivePassword ()  {
            
            do {
                let email = try KeychainManager.retriveData(email: self.email)
                // Process the retrieved credit card data
                // For example, you can convert the data to a string or decode it as needed
                if let emailInfo = String(data: email, encoding: .utf8) {
                    print("Your Password: \(emailInfo)")
                    self.password = emailInfo
                
                } else {
                    print("Failed to convert credit card data to a string.")
                }
            
            }catch{
                print(error)
                
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
        
  
        
        
        
        
    }
}
