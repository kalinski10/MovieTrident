import Foundation
import Combine
import UIKit

protocol NetworkManager {
    
    /// The output of the results from the functions
    var delegate: NetworkManagerOutput? { get set }
    
    /// Bag to store results from combine dataTask
    var bag: Set<AnyCancellable> { get set }
    
    /// Cache to save images and prevent from constant reloading
    var cache: NSCache<NSString, UIImage> { get }
    
    /// Asynchronously tries to download images using swift's new asyn function
    /// - Returns: An optional UIImage
    func downloadImages(from urlString: String) async throws -> UIImage?
    
    /// Retrieves the url required to get a list of movies with type and year if added
    /// - Returns: The url required for loadMovies function to execute
    func getUrl(search: String, type: String, year: String) throws -> URL
    
    /// Retrieves the url required to get a specific movie
    /// - Returns: The url required for loadMovie function to execute
    func getUrl(id: String) throws -> URL
    
    /// Loads the list of movies the user wants to see
    func loadMovies(from url: URL) throws
    
    /// Loads the data required to show a=the detail view of selected movie
    func loadMovie(from url: URL) throws
}
