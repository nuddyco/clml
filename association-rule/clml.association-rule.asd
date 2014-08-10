(asdf:defsystem :clml.association-rule.package
                :pathname "src/"
                :serial t
                :components (
                             (:file "package")))


(asdf:defsystem :clml.association-rule
                :pathname "src/"
                :serial t
                :depends-on (:clml.hjs
                         
                             :clml.association-rule.package
                             )
                :components (
                             (:file "association-rule")
                             (:file "fp-growth")
                             (:file "assoc-da")
                             (:file "eclat")
                             (:file "lcm")
                             ))
