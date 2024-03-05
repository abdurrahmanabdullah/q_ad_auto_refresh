'use strict';

/**
 * lucent-chart router
 */

const { createCoreRouter } = require('@strapi/strapi').factories;

module.exports = createCoreRouter('api::lucent-chart.lucent-chart',{
    config:{
        find:{
    middlewares:['api::lucent-chart.lucent-chart'],
    
        },
        findOne:{
            middlewares:['api::lucent-chart.lucent-chart'],
        }
    },
    
    });



