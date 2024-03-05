
import React from 'react';
import Home from"./components/home";
import Product from './components/products';

import './App.css';

import{ BrowserRouter as Router,Routes,Route} from "react-router-dom"
import About from './components/aboutus';
import CustomNavbar from './components/Nabvar';
import ContactForm from './components/contact';
import Service from './components/service';
import LucentChartComponent from './components/lucentChart';


import PageContainer from '../src/pages/pageContainer';


function App() {
  return (
   
<div>

<div><CustomNavbar/></div>

<Routes>
  <Route path="/" element={<Home />} />  
  <Route path="/home" element={<Home />} />  
  <Route path="/about" element={<About />} />
  <Route path="/product" element={<Product />} /> {/* Add this line for the product route */}
  <Route path="/contact" element={<ContactForm />} /> 
  <Route path="/service" element={<Service />} /> {/* Fix the component name here */}
  <Route path="product/lucentchart" element={<LucentChartComponent />} />
  

  <Route path="/pages/:slug" component={PageContainer} />


</Routes>

</div>

  );
}

export default App;


