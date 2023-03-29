// @refresh reload
import { createComponent, Suspense } from "solid-js";
import {
  useLocation,
  A,
  Body,
  ErrorBoundary,
  Head,
  Html,
  Meta,
  Routes,
  Scripts,
  Title,
} from "solid-start";
import "./root.css";

import Component from "../output/Main/index.js";

export default function Root() {
  // return <Component />
  return createComponent(() => Component, {});
  // return (
  //   <Html lang="en" >
  //     <Head>
  //       <Title>SolidStart PureScript</Title>
  //       <Meta charset="utf-8" />
  //       <Meta name="viewport" content="width=device-width, initial-scale=1" />
  //     </Head>
  //     <Body class="bg-slate-800">
  //       <Suspense>
  //         <ErrorBoundary>
  //           <Routes>
  //             <Suspense fallback="Loading">
  //               {/* <Component /> */}
  //             </Suspense>
  //           </Routes>
  //         </ErrorBoundary>
  //       </Suspense>
  //       <Scripts />
  //     </Body>
  //   </Html>
  // );
}
