'use strict';

/**
 * home router
 */

const { createCoreRouter } = require('@strapi/strapi').factories;

module.exports = createCoreRouter('api::home.home',{
    config:{
        find:{
    middlewares:['api::home.home'],
    
        },
        findOne:{
            middlewares:['api::home.home'],
        }
    },
    
    });