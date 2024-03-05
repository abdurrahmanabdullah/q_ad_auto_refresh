import React, { useState, useEffect } from 'react';
import axios from 'axios';
import ReactPlayer from 'react-player';
import styles from '../App.css';


const LucentChartComponent = () => {
  const [lucentChartData, setLucentChartData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get('http://localhost:1337/api/lucent-chart');
        setLucentChartData(response.data.data);
      } catch (error) {
        console.error('Error fetching data:', error);
        setError(error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []); // Empty dependency array ensures the effect runs only once on mount

  // Handle loading and error states
  if (loading) {
    return <p>Loading...</p>;
  }

  if (error || !lucentChartData) {
    return <p>Error fetching data. Please check the API endpoint.</p>; // Customize error message as needed
  }

  const {
    image,
    video,
    element1,
    element2,
    logo,
    footer,
  } = lucentChartData.attributes;

  return (
    <div style={{padding:"40px"}}>
      <h1 style={{fontWeight: 'normal',textAlign:"center"}}>{lucentChartData.attributes.introductionpart}</h1> 
      {/* Display the image name */}

      <img 
        src={`http://localhost:1337${lucentChartData.attributes.image.data.attributes.url}`}
        alt={lucentChartData.attributes.image.data.attributes.name}
        className="lucent-chart-image"
    
      />
      <p>{lucentChartData.attributes.heading}</p>
      <p>{lucentChartData.attributes.conclusionPart}</p>

    

      {/* Display video using react-player */}
      {video && (
  <div style={{ marginTop: '90px', textAlign: 'center' }}>
 
    <ReactPlayer
      url={`http://localhost:1337${video.data.attributes.url}`}
      width="560px"
      height="315px"
      controls
      style={{ margin: '0 auto' }}
    />
  </div>
)}


      {/* Display other data */}
    
      <p style={{ fontSize: 30, color: 'black', marginBottom: '50px',marginTop:'70px'}} >{element1.heading}</p>
      <p>{element1.subheading}</p>

     
      {element2.map((item) => (
        <div key={item.id}>
          <h4>{item.heading}</h4>
          <ul>
            {item.list.map((listItem) => (
              <li key={listItem.id}>{listItem.item}</li>
            ))}
          </ul>
        </div>
      ))}




    {/* Additional Images */}
    <div className="additional-images">
    {logo.data.map((logoItem, index) => (
      <img
        key={logoItem.id}
        src={`http://localhost:1337${logoItem.attributes.url}`}
        alt={logoItem.attributes.name}
        style={{
          borderRadius: `${index + 1 * 5}px`,
          margin: `${index + 1 * 10}px`,
          padding: `${index + 1 * 8}px`,
          transition: 'background-color 0.3s',
        }}


        
      />


      ))}
      </div>

      {/* Footer Section */}
      {footer && (
        <div className="footer">
          <p style={{ fontWeight: 'bold' }}>{footer}</p>
        </div>
      )}
    </div>
  );
};

export default LucentChartComponent;