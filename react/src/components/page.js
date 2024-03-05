// src/components/Page.js
import React from 'react';

const Page = ({ title, content }) => (
  <div>
    <h1>{title}</h1>
    <div dangerouslySetInnerHTML={{ __html: content }} />
  </div>
);

export default Page;
