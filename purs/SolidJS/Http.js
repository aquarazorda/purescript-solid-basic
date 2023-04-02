import { isServer as isS } from "solid-js/web";

export const isServer = isS;

export const fetch_ = (url) => () => fetch(url).then((r) => r.json());