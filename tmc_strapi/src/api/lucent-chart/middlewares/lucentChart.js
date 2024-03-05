'use strict';

/**
 * `lucentChart` middleware
 */

const populate={

  image:{
    populate:true,fields:["name","url","alt"]
    },
    video:{
    populate:true,fields:["name","url","alt"]
    },
    element1:{
    
    populate:true,
    },
    element2:{
    populate:{list:{populate:true,}}
    },
    conclusionPart:{
    populate:true
    },
    logo:{
    populate:true,fields:["name","url","alt"]
    },
  
  
  };

module.exports = (config, { strapi }) => {
  // Add your own logic here.
  return async (ctx, next) => {
    strapi.log.info('In lucentChart middleware.');

    ctx.query={

      populate,...ctx.query,
    }
    await next();
  };
};


