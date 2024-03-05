'use strict';

/**
 * `home` middleware
 */
const populate={

  slider:{

    populate:true,fields:["name",'url']
    
    
    },
    
    card:{
    
    populate:true,
    
    },
    images:{
    
    populate:true,fields:["name",'url']
    },
    footer:{populate:true}
    
    
    
  
  };
module.exports = (config, { strapi }) => {
  // Add your own logic here.
  return async (ctx, next) => {
    strapi.log.info('In home middleware.');
    ctx.query={

      populate,...ctx.query,
    }
    await next();
  };
};
