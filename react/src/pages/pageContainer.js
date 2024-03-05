// src/pages/PageContainer.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';
import Page from '../components/page';

const PageContainer = ({ match }) => {
  const [pageData, setPageData] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get(`http://localhost:1337/pages/${match.params.slug}`);
        setPageData(response.data);
      } catch (error) {
        console.error('Error fetching page data:', error);
      }
    };

    fetchData();
  }, [match.params.slug]);

  return <>{pageData && <Page {...pageData} />}</>;
};

export default PageContainer;
