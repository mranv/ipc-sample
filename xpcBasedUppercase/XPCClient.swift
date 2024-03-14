//
//  XPCClient.swift
//  xpcBasedUppercase
//
//  Created by Anubhav Gain on 14/03/24.
//


import Foundation

protocol XPCClientProtocol {
    func uppercase(for inputString: String, completion: @escaping (String) -> Void)
    func close()
}

class XPCClient: XPCClientProtocol {
    private let connection: NSXPCConnection
    private let service: xpcServiceProtocol
    
    init() {
        connection = NSXPCConnection(serviceName: "mranv.xpcService")
        connection.remoteObjectInterface = NSXPCInterface(with:
                                                            xpcServiceProtocol.self)
        connection.resume()
        
        service = connection.remoteObjectProxyWithErrorHandler { error in
            print("Error during remote connection: ", error)
        } as! xpcServiceProtocol
        
    }
    
    deinit {
        connection.invalidate()
    }
    
    func uppercase(for inputString: String, completion: @escaping (String) -> Void) {
        service.uppercase(string: inputString, with: { (uppercasedString) in
            completion(uppercasedString)
        })
    }
    
    func close() {
        service.close()
    }
}

class MockedXPCCLient: XPCClientProtocol {
    func uppercase(for inputString: String, completion: @escaping (String) -> Void) {}
    func close() {}
}

