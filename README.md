# PureScript SolidStart FFI

### This branch contains SolidStart + PureScript + TailwindCSS

In order to run the project, you have to execute these commands:

```bash
yarn install
spago install
spago build
yarn dev
```

Basically, in `/src/root.tsx` you'll see import from PureScript's output.
If you change `router` function to `default` and in `root.tsx` uncomment Solid code + line 33, you'll see that it works just fine.
But seems like when I'm moving everything to PureScript side, execution order is not correct, so it errors.

- Done??
  - createEffect
  - createSignal
  - createResource
  - createMemo
  - createComponent
- Render
  - render
  - fragment
  - lazy
  - Dynamic
  - Show
  - ShowMaybe