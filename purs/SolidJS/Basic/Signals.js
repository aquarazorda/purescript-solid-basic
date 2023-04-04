import { createMemo as _createMemo } from 'solid-js';

export const createMemo = _createMemo;

export const memoProp = (val) => ({
  memo: val
});