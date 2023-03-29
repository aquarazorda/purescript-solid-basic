let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.7-20230310/packages.dhall
        sha256:c30c50d19c9eb55516b0a8a1bd368a0754bde47365be36abadb489295d86d77c

in  upstream
  with undefined-or = {
    repo = "https://github.com/d86leader/purescript-undefined-or"
  , version = "master"
  , dependencies = [ "maybe", "prelude" ]
  }
