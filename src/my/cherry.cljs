(ns my.cherry
  (:require [cherry.embed :as cherry]))

(cherry/preserve-ns 'cljs.core)
(cherry/preserve-ns 'clojure.string)

(defn init []
  (prn (cherry/eval-string "(+ 1 2 3)")))

(prn :dude)
