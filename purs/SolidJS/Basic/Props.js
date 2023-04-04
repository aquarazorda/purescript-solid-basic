export const toGetterPropAccessor = (key) => (fn) => ({
  get [key]() {
    return fn();
  }
})

export const toGetterProp = (key) => (val) => ({
  get [key]() {
    return val;
  }
});