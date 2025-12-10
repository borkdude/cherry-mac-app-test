(ns my.cherry
  (:require [cherry.embed :as cherry]))

(cherry/preserve-ns 'cljs.core)
(cherry/preserve-ns 'clojure.string)

(def exports #js {:evalString cherry/eval-string})

(defn init []
  (set! js/globalThis.cherry exports))
