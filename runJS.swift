import Foundation
import JavaScriptCore

// Create a JS context
let context = JSContext()!

extension JSContext {
    func injectConsoleLog() {

        evaluateScript(
          """
            var console = {};
            """
        )
        let consoleLog: @convention(block) (Any) -> Void = {
            print($0)
        }
        objectForKeyedSubscript("console")
          .setObject(consoleLog, forKeyedSubscript: "log" as NSString)
    }
}

context.injectConsoleLog()

// Optional: handle JS exceptions
context.exceptionHandler = { context, exception in
    print("JS Error: \(exception!)")
}

let fileURL = URL(fileURLWithPath: "out/cherry.eval.js")

guard let jsCode = try? String(contentsOf: fileURL, encoding: .utf8) else {
    print("Failed to read JS file")
    exit(1)
}

let result = context.evaluateScript(jsCode)

let evalString = context.evaluateScript("cherry.evalString")
let ret = evalString?.call(withArguments: ["(+ 1 2 3)"])
print("Result:", ret)


evalString?.call(withArguments: ["(defn foo [] (+ 1 2 3))"])
let ret2 = evalString?.call(withArguments: ["(foo)"])
print("Result:", ret2)


let _ = evalString?.call(withArguments: ["(def size 64)"])

if let size = context.objectForKeyedSubscript("size"), !size.isUndefined {
    print(Int(size.toInt32()))
}


let _ = evalString?.call(withArguments: ["(defn two-times [x] (* 2 x))"])
let _ = evalString?.call(withArguments: ["(prn (two-times 33))"])


if let result = context.evaluateScript("two_times(1)"), !result.isUndefined {
    print(result)
}
