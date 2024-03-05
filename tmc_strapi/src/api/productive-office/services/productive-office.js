'use strict';

/**
 * productive-office service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::productive-office.productive-office');
