import UIKit
import PlaygroundSupport

// See: https://milen.me/writings/swift-generic-protocols/

protocol GenericProtocol {
    associatedtype AbstractType
    func content() -> AbstractType
}

struct GenericProtocolThunk<T> : GenericProtocol {
    
    private let _content : () -> T
    
    init<P : GenericProtocol>(_ dep : P) where P.AbstractType == T {
        _content = dep.content
    }
    
    func content() -> T {
        return _content()
    }
}

struct StringMagic : GenericProtocol {
    
    typealias AbstractType = String
    
    func content() -> String {
        return "String content 🎉"
    }
}

struct IntMagic : GenericProtocol {
    
    typealias AbstractType = Int
    
    func content() -> Int {
        return 3
    }
}

class RequestBuilder<ResponseType> {
    
    let parser: GenericProtocolThunk<ResponseType>
    
    init(parser: GenericProtocolThunk<ResponseType>) {
        self.parser = parser
    }
    
    func parse() -> ResponseType {
        return parser.content()
    }
}

var thunkString: GenericProtocolThunk<String> = GenericProtocolThunk(StringMagic())
var requestString = RequestBuilder<String>(parser: thunkString)
requestString.parse()

var thunkInt: GenericProtocolThunk<Int> = GenericProtocolThunk(IntMagic())
let requestInt = RequestBuilder<Int>(parser: thunkInt)
requestInt.parse()

