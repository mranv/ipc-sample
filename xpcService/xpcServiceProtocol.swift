//
//  xpcServiceProtocol.swift
//  xpcService
//
//  Created by Anubhav Gain on 14/03/24.
//

import Foundation

/// The protocol that this service will vend as its API. This protocol will also need to be visible to the process hosting the service.
@objc protocol xpcServiceProtocol {
    func uppercase(string: String, with reply: @escaping (String) -> Void)
    func close()
}

/*
 To use the service from an application or other process, use NSXPCConnection to establish a connection to the service by doing something like this:

     connectionToService = NSXPCConnection(serviceName: "com.atcults.xpcService")
     connectionToService.remoteObjectInterface = NSXPCInterface(with: xpcServiceProtocol.self)
     connectionToService.resume()

 Once you have a connection to the service, you can use it like this:

     if let proxy = connectionToService.remoteObjectProxy as? xpcServiceProtocol {
         proxy.performCalculation(firstNumber: 23, secondNumber: 19) { result in
             NSLog("Result of calculation is: \(result)")
         }
     }

 And, when you are finished with the service, clean up the connection like this:

     connectionToService.invalidate()
*/
