import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useSpring, animated } from 'react-spring';
import Slider from 'react-animated-slider';
import 'react-animated-slider/build/horizontal.css';
import Card from './card/card';
import styles from '../App.css';

const settings = {
  dots: true,
  infinite: true,
  speed: 200,
  slidesToShow: 1,
  slidesToScroll: 1,
  fade: true, // Add fade animation
};
const Product = () => {
  const [productData, setProductData] = useState(null);

  useEffect(() => {
    const fetchProductData = async () => {
      try {
        const response = await fetch('http://localhost:1337/api/homes');
        const data = await response.json();
        setProductData(data.data[0]);
      } catch (error) {
        console.error('Error fetching product data:', error);
      }
    };

    fetchProductData();
  }, []);

  const fade = useSpring({ from: { opacity: 0 }, opacity: 1 });

  return (
    ///heading section 
    <animated.div style={fade}>
      {productData && (
        <div style={{ flex: 1, marginLeft: '60px',marginBottom:'100px'}}> 
       <h1 style={{fontFamily: 'Myriad Pro Regular',fontWeight: 'bolder', textAlign: 'center',color:'#3E8B94',marginBottom:'50px',marginTop:'70px' }}>{productData.attributes.heading}</h1>
       <p style={ { fontWeight:'bolder'}}>{productData.attributes.subheading}</p>
   
 {/* Space between heading and image slider */}
 <div style={{ marginBottom: '50px' }}></div>
          {/* Image Slider */}
          <Slider style={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
  {productData.attributes.slider.data.map((slide) => (
    <div key={slide.id} style={{ width: '100%', height: '100%' }}>
      <img
        src={`http://localhost:1337${slide.attributes.url}`}
        alt={slide.attributes.name}
        style={{ width: '100%', height: '100%', objectFit: 'cover' }}
      />
    </div>
  ))}
</Slider>

        {/* Card Section */}
        <div>
            {productData.attributes.card.map((card) => (
              <Card
              title={<div className="title-bold-center">{card.title}</div>} 
              subtitle={card.subtitle} 
              subhead={<div className="button-center"> {card.button && <a href="https://transworldbd.com/index.php/products/productive-office" >{card.button}</a>} </div>} 
              // button={<button className="button-center">Click me</button>}
           
              // button={<div>{card.button} </div>}
              
              />
            ))}
          </div>

          {/* Additional Images */}
          <div className="additional-images">
            {productData.attributes.images.data.map((image, index) => (
              <img
                key={image.id}
                src={`http://localhost:1337${image.attributes.url}`}
                alt={image.attributes.name}
                style={{
                  borderRadius: `${index + 1 * 5}px`, // Set individual border radius for each image
                  margin: `${index + 1 * 10}px`, // Set individual margin for each image
                  padding: `${index + 1 * 8}px`, // Set individual padding for each image
                  transition: 'background-color 0.3s',
                }}
              />
            ))}
          </div>
          
          {/* Footer Section */}
          {productData.attributes.footer && (
            <div className="footer">
              <p style={{fontWeight:'bold'}}>{productData.attributes.footer}</p>
            </div>
          )}
        </div>
      )}
    </animated.div>
  );
};

export default Product;