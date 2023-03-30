import { lazy } from "solid-js";
import "./root.css";

const Component = lazy(() => import("../output/Main/index.js"));

export default function Root() {
  return <Component />
}
