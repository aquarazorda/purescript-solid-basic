import { isServer as isS } from "solid-js/web";

export const isServer = isS;

export const getFetch = () => fetch