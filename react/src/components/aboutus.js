import React, { useState, useEffect } from 'react';

const About = () => {
  const [aboutUsData, setAboutUsData] = useState(null);
  const [additionalImages, setAdditionalImages] = useState([]);
  const [footer, setFooter] = useState('');
 const coreapi=""
  useEffect(() => {
    const fetchData = async () => {
      try {
        // Fetch data from about-uses API
        const aboutUsResponse = await fetch('http://localhost:1337/api/about-uses?populate=*');
        const aboutUsData = await aboutUsResponse.json();
        setAboutUsData(aboutUsData.data[0]);

        // Fetch additional images from homes API
        const homesResponse = await fetch('http://localhost:1337/api/homes');
        const homesData = await homesResponse.json();
        if (homesData.data && homesData.data.length > 0) {
          const images = homesData.data[0].attributes.images.data;
          const footerText = homesData.data[0].attributes.footer;
          setAdditionalImages(images);
          setFooter(footerText);
        }
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  return (
    <div>
      {aboutUsData && aboutUsData.attributes && (
        <div>
          {aboutUsData.attributes.content.map((item) => (
            <div key={item.id} style={{ marginBottom: '20px', padding: '15px'}}>
              <h2 style={{ fontWeight: 'normal', fontSize: '24px', color: '#333' }}>{item.heading}</h2>
              <p style={{ fontWeight: 'normal', fontSize: '16px', color: '#666' }}>{item.subheading}</p>
            </div>
          ))}

          {/* Additional Images */}
          {additionalImages.length > 0 && (
            <div className="additional-images">
              {additionalImages.map((image, index) => (
                <img
                  key={image.id}
                  src={`http://localhost:1337${image.attributes.url}`}
                  alt={image.attributes.name}
                  style={{
                    borderRadius: `${index + 1 * 5}px`,
                    margin: `${index + 1 * 10}px`,
                    padding: `${index + 1 * 8}px`,
                    transition: 'background-color 0.3s',
                  }}
                />
              ))}
            </div>
          )}

       {/* Footer Section */}
       {footer && (
            <div className="footer">
              <p>{footer}</p>
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default About;