module SolidJS.Basic.Props where

import Prelude
import SolidJS.Basic.Signals (Accessor)
import Type.Proxy (Proxy(..))

type Prop r
  = Record r

type Props r
  = Array (Prop r)

class FromStringSymbol (str :: Symbol) (proxy :: Type) | proxy -> str where
  strProxy :: proxy -> Proxy str

instance stringFromStringSymbol :: FromStringSymbol str (String -> String) where
  strProxy _ = Proxy

foreign import toGetterPropAccessor :: forall a str r. Proxy str -> Accessor a -> Prop ( str :: a | r )

tgpa ::
  forall a r str proxy.
  FromStringSymbol str proxy =>
  proxy -> Accessor a -> Prop ( str :: a | r )
tgpa name value = toGetterPropAccessor (strProxy name) value

infix 0 tgpa as @=

foreign import toGetterProp :: forall a str r. Proxy str -> a -> Prop ( str :: a | r )

tgp :: forall a r str proxy. FromStringSymbol str proxy => proxy -> a -> Prop ( str :: a | r )
tgp name value = toGetterProp (strProxy name) value

infix 0 tgp as :=

addProp ::
  forall a r str proxy.
  FromStringSymbol str proxy =>
  proxy -> a -> Props ( str :: a | r ) -> Props ( str :: a | r )
addProp name value props = props <> [ name := value ]
