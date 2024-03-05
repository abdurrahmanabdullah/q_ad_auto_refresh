import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter } from 'react-router-dom';
import App from './App';

ReactDOM.render(
  <BrowserRouter>
    <App /> 
  </BrowserRouter>,
  document.getElementById('root')
);


// import React from 'react';
// import ReactDOM from 'react-dom';

// import { BrowserRouter } from 'react-router-dom';
// import App from './App';

// import {
//   createBrowserRouter,
//   RouterProvider,
// } from "react-router-dom";
// const router = createBrowserRouter([
//   {
//     path: "/",
//     element: <div>Hello world!</div>,
//   },
// ]);
// const root=ReactDom.createRoot(document.getElementById('root'));
// root.render(<RouterProvider route={router}/>)