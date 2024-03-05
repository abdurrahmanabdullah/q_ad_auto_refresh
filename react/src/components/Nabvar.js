

import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import PersistentDrawerRight from './drawer/drawer';


const NavbarMenu = ({ menu, isOpen, handleMouseEnter, handleMouseLeave, handleToggle }) => (
  <Link to={`/${menu.attributes.slug}`} style={{ textDecoration: 'none', color: 'black' }}>
    <div
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}
      onClick={handleToggle}
      style={{ cursor: 'pointer', position: 'relative', display: 'flex', alignItems: 'center' }}
    >
      <div style={{ flex: 1 }}>
        {menu.attributes.name}
      </div>
      <div style={{ marginLeft: '5px' }}>{isOpen ? '▲' : '▼'}</div>
      {isOpen && (
        <div
          style={{
            position: 'absolute',
            top: '100%',
            right: '-10px',
            background: '#f2f2f2',
            padding: '50px',
            display: 'flex',
            flexDirection: 'column',
            zIndex: 1,
            borderRadius: '10px',
            border: '1px solid #ccc',
            whiteSpace: 'nowrap',
          }}
        >
          {menu.attributes.navbar_menus.data.map(submenu => (
           <Link
           key={submenu.id}
           to={`/${menu.attributes.slug}/${submenu.attributes.slug || submenu.attributes.name}`}
           style={{ margin: '5px 0', textDecoration: 'none', color: 'black' }}
         >
           {submenu.attributes.name}
         </Link>
          ))}
          

          
        </div>
      )}
    </div>
  </Link>
);

const CustomNavbar = () => {

  

  const [navbarMenus, setNavbarMenus] = useState([]);
  const [logoUrl, setLogoUrl] = useState('');
  const [isProductMenuOpen, setProductMenuOpen] = useState(false);
  const [isServiceMenuOpen, setServiceMenuOpen] = useState(false);
  const [isDrawerOpen, setDrawerOpen] = useState(false);
  
///drawer

const handleDrawerOpen = () => {
  setDrawerOpen(true);
};

const handleDrawerClose = () => {
  setDrawerOpen(false);
};

  const fetchData = async () => {
    try {
      const response = await fetch('http://localhost:1337/api/navbarmenus?populate=deep,10');
      const data = await response.json();
      setNavbarMenus(data.data);

      const logoResponse = await fetch('http://localhost:1337/uploads/TMC_Logo_2ec3db61b5.png');
      const logoData = await logoResponse.blob();
      setLogoUrl(URL.createObjectURL(logoData));
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

  useEffect(() => {
    fetchData();
  }, []); 

  const handleMenuToggle = (menuType, isOpen, setOpen) => {
    if (isOpen) {
      setOpen(false);
    } else {
      setProductMenuOpen(false);
      setServiceMenuOpen(false);
      setOpen(true);
    }
  };

  const handleProductMenuToggle = () => {
    handleMenuToggle('product', isProductMenuOpen, setProductMenuOpen);
  };

  const handleServiceMenuToggle = () => {
    handleMenuToggle('service', isServiceMenuOpen, setServiceMenuOpen);
  };

  const handleMenuMouseEnter = (menuType, setOpen) => {
    if (!isProductMenuOpen && !isServiceMenuOpen) {
      setOpen(true);
    }
  };

  const handleMenuMouseLeave = (setOpen) => {
    setOpen(false);
  };

  return (
    <div style={{ background: '#f2f2f2', padding: '10px', textAlign: 'left', display: 'flex', alignItems: 'center'}}>
      {logoUrl && (
        <img src={logoUrl} alt="Logo" style={{ height: '50px', marginRight: '350px',marginLeft:'10px' }} />
      )}
       



{/* Add the Drawer component */}
<PersistentDrawerRight open={isDrawerOpen} onClose={handleDrawerClose}  />
 <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', flexWrap: 'wrap' }}>
  



 </div>
      {navbarMenus.map(menu => (
        <div key={menu.id} style={{ position: 'relative', marginLeft: '10px' }}>
          {menu.attributes.slug === 'product' ? (
            <NavbarMenu
              menu={menu}
              isOpen={isProductMenuOpen}
              handleMouseEnter={() => handleMenuMouseEnter('product', setProductMenuOpen)}
              handleMouseLeave={() => handleMenuMouseLeave(setProductMenuOpen)}
              handleToggle={handleProductMenuToggle}
            />
          ) : menu.attributes.slug === 'service' ? (
            <NavbarMenu
              menu={menu}
              isOpen={isServiceMenuOpen}
              handleMouseEnter={() => handleMenuMouseEnter('service', setServiceMenuOpen)}
              handleMouseLeave={() => handleMenuMouseLeave(setServiceMenuOpen)}
              handleToggle={handleServiceMenuToggle}
            />
          ) : (
            <Link
              to={`/${menu.attributes.slug}`}
              style={{ margin: '0 10px', textDecoration: 'none', color: 'black' }}
            >
              {menu.attributes.name}
            </Link>
          )}
        </div>
      ))}
    </div>
  );
};

export default CustomNavbar;
