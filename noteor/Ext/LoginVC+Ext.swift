//
//  LoginVC+Ext.swift
//  noteor
//
//  Created by Emir AKSU on 1.05.2024.
//

import Foundation
import AuthenticationServices
import FirebaseAuth
import CryptoKit

extension LoginVC  : ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding  {
    
    
    
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed")
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                
                UserDefaults.standard.set(appleIDCredential.user, forKey: "appleAuthorizedUserIdKey")
                
                // Retrieve the secure nonce generated during Apple sign in
                guard let nonce = currentNonce else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }

                // Retrieve Apple identity token
                guard let appleIDToken = appleIDCredential.identityToken else {
                    print("Failed to fetch identity token")
                    return
                }

                // Convert Apple identity token to string
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Failed to decode identity token")
                    return
                }

                // Initialize a Firebase credential using secure nonce and Apple identity token
                let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com",
                                                                  idToken: idTokenString,
                                                                  rawNonce: nonce)
                
                Auth.auth().signIn(with: firebaseCredential) { [weak self] (authResult, error) in
                    print("SignIn succes")
                    print(appleIDCredential.fullName)
                }
              
            }
    }
    
    
     func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }

     func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    
    
}
