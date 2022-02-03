//
//  NetworkService.swift
//
//
//  Created by Amit Jain on 1/28/22.
//

import Foundation

public enum HttpMethod : String, Codable {
    case GET
    case POST
    case PUT
    case DELETE
    
    func enumToString() -> String {
        return self.rawValue
    }
}

//force every service implementing NetworkService to set path (& other request params)
public protocol NetworkService {
    var path:String { get set }
    var httpMethodtype:HttpMethod  { get }
    var parameters: [String:Any] { get set }
    init(parameters: [String : Any])
}

extension NetworkService {
    var httpMethodType:HttpMethod { return .GET} //default data

    func getBaseUrl() -> String {
        return "https://secure.fleetio.com/api/v1"
    }

    
    func fetchAPI<GenericModel: Decodable>() async throws -> (GenericModel, [AnyHashable : Any]) {
        if  getBaseUrl().isEmpty  {
            fatalError("Missing URL")
        }
        if self.path.isEmpty  {
            fatalError("Missing Path")
        }
        guard let fullUrl = URL(string: getBaseUrl() + self.path) else {
            fatalError("Missing full URL")
        }
        guard var urlRequest = createGetRequestWithURLComponents(url: fullUrl, parameters: self.parameters, requestType: self.httpMethodtype)  else { fatalError("Missing url components")
        }
        urlRequest.addValue("798819214b", forHTTPHeaderField: "Account-Token")
        urlRequest.setValue("Token token=a3ddc620b35b609682192c167de1b1f3f5100387", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data")
        }
        
        //extract response headers
        var allHeaderFields:[AnyHashable : Any]!
        if let httpresponse = (response as? HTTPURLResponse){
            allHeaderFields = httpresponse.allHeaderFields
            print("All headers: \(String(describing: allHeaderFields))")
            let pageNumber = httpresponse.value(forHTTPHeaderField: "X-Pagination-Current-Page")
            print ("page returned:\(String(describing: pageNumber))")
            print ("page= \(String(describing: allHeaderFields["X-Pagination-Current-Page"]))")
            print ("page= \(String(describing: allHeaderFields["X-Pagination-Total-Pages"]))")
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        let decodedData = try decoder.decode(GenericModel.self, from: data)
        return (decodedData,allHeaderFields)
    }
    
    private func createGetRequestWithURLComponents(url:URL,
                                                   parameters: [String:Any],
                                                   requestType: HttpMethod) -> URLRequest? {
        var components = URLComponents(string: url.absoluteString)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: "\(value)")
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url ?? url)
        request.httpMethod = requestType.rawValue
        return request
    }
}
