import React, { useState,useEffect  } from 'react';
import styles from '../App.css';

const ContactForm = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    subject: '',
    message: '',
    privacy: false,
    privacyCopy: false,
  });
///contact info ....
const [contactInfo, setContactInfo] = useState(null);
const [imageData, setImageData] = useState(null);

// Define imageData using useState
useEffect(() => {
  const fetchContactInfo = async () => {
    try {
      const response = await fetch('http://localhost:1337/api/contact-info?populate=deep,10');
      const data = await response.json();
      setContactInfo(data.data.attributes.contact);

      // Fetch the image using the URL from the API response
      const imageUrl = `http://localhost:1337${data.data.attributes.contact.image.data.attributes.url}`;
      setImageData({
        url: imageUrl,
        alt: data.data.attributes.contact.image.data.attributes.name,
      });
    } catch (error) {
      console.error('Error fetching contact information', error);
    }
  };

  fetchContactInfo();
}, []);


  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData((prevFormData) => ({
      ...prevFormData,
      [name]: type === 'checkbox' ? checked : value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
  
    try {
      const response = await fetch('http://localhost:1337/api/contacts', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          // Add your Strapi API key as an Authorization header if necessary
          // 'Authorization': `Bearer YOUR_STRAPI_API_KEY`,
        },
        body: JSON.stringify({
          data: {
            // Map form data to the structure expected by Strapi API
            Name: formData.name,
            Email: formData.email,
            Subject: formData.subject,
            Message: formData.message,
            Privacy: formData.privacy,
            // Add fields for privacyCopy if needed and mapped to relevant fields
          }
        }),
      });
  
      if (response.ok) {
        console.log('Form data sent successfully!');
        // Optionally, you can redirect or perform other actions upon successful submission
      } else {
        const errorData = await response.json();
        console.error('Error sending form data', errorData);
      }
    } catch (error) {
      console.error('Error sending form data', error);
    }
  };
  
  return (
    <div style={{ display: 'flex', margin: '70px' }}>
    {/* First Column: Contact Form */}
    <div style={{ flex: 1, marginRight: '20px' }}>
      <h1 style={{ fontSize: '24px', color: 'green' }}>Get In Touch</h1>
      <h2 style={{ fontWeight: 'bold', margin: '10px 0' }}>Contact Form</h2>
      <p style={{ fontSize: '16px', marginBottom: '15px' }}>
        Send an Email. All fields with an asterisk (*) are required.
      </p>

      <form onSubmit={handleSubmit}>
        <div style={{ display: 'flex', marginBottom: '15px' }}>
          <div style={{ flex: 1, marginRight: '10px' }}>
            <label htmlFor="name">Name *</label>
            <input
              type="text"
              id="name"
              name="name"
              required
              value={formData.name}
              onChange={handleChange}
              style={{ width: '100%', padding: '9px' }}
            />
          </div>
          <div style={{ flex: 1, marginLeft: '20px' }}>
            <label htmlFor="email">Email *</label>
            <input
              type="email"
              id="email"
              name="email"
              required
              value={formData.email}
              onChange={handleChange}
              style={{ width: '100%', padding: '9px' }}
            />
          </div>
        </div>

        <div style={{ marginBottom: '15px' }}>
          <label htmlFor="subject">Subject *</label>
          <input
            type="text"
            id="subject"
            name="subject"
            required
            value={formData.subject}
            onChange={handleChange}
            style={{ width: '100%', padding: '18px' }}
          />
        </div>

        <div style={{ marginBottom: '50px' }}>
          <label htmlFor="message">Message *</label>
          <textarea
            id="message"
            name="message"
            rows="8"
            required
            value={formData.message}
            onChange={handleChange}
            style={{ width: '100%', padding: '18px' }}
          ></textarea>
        </div>

        <div style={{ marginBottom: '15px' }}>
          <label htmlFor="privacy">Privacy Note *</label>
          <div>
            <input
              type="checkbox"
              id="privacy"
              name="privacy"
              required
              checked={formData.privacy}
              onChange={handleChange}
            />
            <span style={{ marginLeft: '5px' }}>
              By submitting this form you agree to the Privacy Policy of this website and the storing of the submitted information.
            </span>
          </div>
          <div>
            <input
              type="checkbox"
              id="privacyCopy"
              name="privacyCopy"
              required
              checked={formData.privacyCopy}
              onChange={handleChange}
            />
            <span style={{ marginLeft: '5px' }}>
              Send a copy to yourself.
            </span>
          </div>
            <div style={{ marginBottom: '55px' }}>
        </div>
      
        <button type="submit" className="send-email-button">
          Send Email
        </button>
        </div>
      </form>
      </div>
     {/* Second Column */}
     <div style={{ flex: 1, marginLeft: '120px' }}> 
       
        {contactInfo && (
          <div>
            <p style={{ color: 'blue', fontSize: '16px', fontWeight: 'normal' }}>Contact</p>
            <p style={{ fontWeight: 'normal', fontSize: '30px' }}>{contactInfo.name}</p>
            <p>ADDRESS </p>
            <p> {contactInfo.address}</p>
            <p>TELEPHONE </p>
            <p> {contactInfo.telephone}</p>
            <p> MOBILE</p>
            <p> {contactInfo.mobile}</p>
            <p> WEBSITE</p>
            <p><a href={contactInfo.website} target="_blank">{contactInfo.website}</a></p>
            {/* Add other contact information fields as needed */}
          </div>
        )}
  
  {imageData && (
        <div>
          <img src={imageData.url} alt={imageData.alt} style={{ maxWidth: '80%', height: 'auto' }} />
        </div>
      )}


    
      </div>

        {/* footer section  */}
   
        {contactInfo && contactInfo.footer && (
          <div className="footer">
            <p style={{ fontWeight: 'bold' }}>{contactInfo.footer}</p>
          </div>
        )}

    </div>

    
  );
};

export default ContactForm;