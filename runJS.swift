import Foundation
import JavaScriptCore

// Create a JS context
let context = JSContext()!

// Optional: handle JS exceptions
context.exceptionHandler = { context, exception in
    print("JS Error: \(exception!)")
}

let fileURL = URL(fileURLWithPath: "out/eval.js")

guard let jsCode = try? String(contentsOf: fileURL, encoding: .utf8) else {
    print("Failed to read JS file")
    exit(1)
}

// Your JS code
let result = context.evaluateScript(jsCode)

print("Result:", result!)
