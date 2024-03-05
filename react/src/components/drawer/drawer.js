import * as React from 'react';
import { styled, useTheme } from '@mui/material/styles';
import Box from '@mui/material/Box';
import Drawer from '@mui/material/Drawer';
import MuiAppBar, { AppBarProps as MuiAppBarProps } from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import CssBaseline from '@mui/material/CssBaseline';
import List from '@mui/material/List';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import InboxIcon from '@mui/icons-material/MoveToInbox';
import MailIcon from '@mui/icons-material/Mail';
import { Link } from 'react-router-dom';
const drawerWidth = 300;

const Main = styled('main', { shouldForwardProp: (prop) => prop !== 'open' })(({ theme, open }) => ({
  flexGrow: 1,
  padding: theme.spacing(1),
  transition: theme.transitions.create('margin', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  marginRight: -drawerWidth,
  ...(open && {
    transition: theme.transitions.create('margin', {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen,
    }),
    marginRight: 0,
  }),
  position: 'relative',
}));

const DrawerHeader = styled('div')(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  padding: theme.spacing(0, 1),
  ...theme.mixins.toolbar,
  justifyContent: 'center', // Center the icon horizontally
}));

export default function PersistentDrawerRight() {
  const [open, setOpen] = React.useState(false);

  const handleDrawerOpen = () => {
    setOpen(true);
  };

  const handleDrawerClose = () => {
    setOpen(false);
  };

  return (
    <Box sx={{ display: 'flex' }}>
      <CssBaseline />
      <Main open={open}>
        {/* Content here */}
      </Main>
      <Drawer
        sx={{
          width: drawerWidth,
          flexShrink: 0,
          '& .MuiDrawer-paper': {
            width: drawerWidth,
          },
        }}
        variant="persistent"
        anchor="right"
        open={open}
      >
        {/* **Removed unnecessary content:** */}
        <DrawerHeader>
          <IconButton onClick={handleDrawerClose}>
            <ChevronRightIcon />
          </IconButton>
        </DrawerHeader >
        {/* Divider removed to avoid visual separation */}
        <List>
        <Link to="/home" className="linkStyle">
            <ListItem >
              <ListItemIcon>
              </ListItemIcon>
              <ListItemText primary="Home" />
            </ListItem>
          </Link>
          <Link to="/about" className="linkStyle">
            <ListItem >
              <ListItemIcon>
             
              </ListItemIcon>
              <ListItemText primary="About" />
            </ListItem>
          </Link>
          <Link to="/product"className="linkStyle">
            <ListItem button>
              <ListItemIcon>
             
              </ListItemIcon>
              <ListItemText primary="Product" />
            </ListItem>
          </Link>
          <List style={{ marginLeft: '20px' }}>
          <Link to="/product/iptelephoneservice&solution"  className="linkStyle">
              <ListItem button>
                <ListItemIcon>
                 
                </ListItemIcon>
                <ListItemText primary="Ip Telephone Service And Solution" />
              </ListItem>
            </Link>
            <Link to="/product/productoffice" className="linkStyle">
              <ListItem button>
                <ListItemIcon>
                  
                </ListItemIcon>
                <ListItemText primary="Product Office" />
              </ListItem>
            </Link>
            <Link to="/product/videoconferencesolution" className="linkStyle">
              <ListItem button>
                <ListItemIcon>
               
                </ListItemIcon>
                <ListItemText primary="Video Conference Solution" />
              </ListItem>
            </Link>

            <Link to="/product/securitysolution"className="linkStyle">
              <ListItem button>
                <ListItemIcon>
               
                </ListItemIcon>
                <ListItemText primary="Security Solution" />
              </ListItem>
            </Link>
            <Link to="/product/lucentchart"className="linkStyle">
              <ListItem button>
                <ListItemIcon>
                
                </ListItemIcon>
                <ListItemText primary="Lucent chart" />
              </ListItem>
            </Link>
            {/* Add more submenus as needed */}
          </List>
          <Link to="/service" className="linkStyle">
            <ListItem button>
              <ListItemIcon>
             
              </ListItemIcon>
              <ListItemText primary="Service" />
            </ListItem> 
              
          </Link>
          <List style={{ marginLeft: '20px' }}>

          <Link to="/service/businessanalysis&consultancy" className="linkStyle">
              <ListItem button>
                <ListItemIcon>
              
                </ListItemIcon>
                <ListItemText  primary="Business Analysis And Consultancy"/>
              </ListItem>
            </Link>
            <Link to="/service/manageitsupportservice "className="linkStyle"> 
          
              <ListItem button>
                <ListItemIcon>
                 
                </ListItemIcon>
                <ListItemText  primary="Manage It Support Service" />
              </ListItem>
            </Link>
            <Link to="/service/emailmigrationandmanagement" className="linkStyle">
              <ListItem button>
                <ListItemIcon>
                 
                </ListItemIcon>
                <ListItemText style={{fontWeight:"bold"}} primary="Email Migration And Management" />
              </ListItem>
            </Link>
            <Link to="/service/managecloudservices" className="linkStyle">
              <ListItem button>
                <ListItemIcon>
                 
                </ListItemIcon>
                <ListItemText style={{fontWeight:"bold"}} primary="Manage Cloud Services" />
              </ListItem>
            </Link>
          </List>
          <Link to="/contact" className="linkStyle">
            <ListItem button>
              <ListItemIcon>
                
              </ListItemIcon>
              <ListItemText primary="Contact" />
            </ListItem>
          </Link>
          {/* Add additional menu items as needed */}
        </List>
      </Drawer>
      {/* Drawer icon */}
      <IconButton
        color="blue"
        aria-label="open drawer"
        edge="end"
        onClick={handleDrawerOpen}
        sx={{ position: 'fixed', right: 50, top: 12}}
      >
        <MenuIcon />
      </IconButton>
    </Box>
  );
}