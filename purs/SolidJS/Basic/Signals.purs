module SolidJS.Basic.Signals where

import Prelude
import Data.Function.Uncurried (mkFn0, runFn0)
import Effect (Effect)
import Unsafe.Coerce (unsafeCoerce)

data Accessor a
  = Accessor a

foreign import createMemo :: forall a. (Unit -> a) -> Accessor a

createMemo_ :: forall a. Effect a -> Accessor a
createMemo_ = unsafeCoerce createMemo

access :: forall a. Accessor a -> a
access = unsafeCoerce runFn0

foreign import memoProp :: forall a. Accessor a -> a

instance functorAccessor :: Functor Accessor where
  map f x = createMemo \_ -> f $ access x

instance applyAccessor :: Apply Accessor where
  apply f x = createMemo \_ -> access f $ access x

instance bindAccessor :: Bind Accessor where
  bind acc fn = createMemo \_ -> access $ fn $ access acc

instance applicativeAccessor :: Applicative Accessor where
  pure x = unsafeCoerce $ mkFn0 (\_ -> x)
