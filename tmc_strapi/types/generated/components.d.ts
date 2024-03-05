import type { Schema, Attribute } from '@strapi/strapi';

export interface CardContentCard extends Schema.Component {
  collectionName: 'components_card_content_cards';
  info: {
    displayName: 'card';
  };
  attributes: {
    title: Attribute.String;
    subtitle: Attribute.Text;
    button: Attribute.String;
  };
}

export interface ContactContact extends Schema.Component {
  collectionName: 'components_contact_contacts';
  info: {
    displayName: 'contact';
    description: '';
  };
  attributes: {
    name: Attribute.String;
    image: Attribute.Media;
    address: Attribute.String;
    telephone: Attribute.String;
    mobile: Attribute.String;
    website: Attribute.String;
    footer: Attribute.String;
  };
}

export interface ContentBlog extends Schema.Component {
  collectionName: 'components_content_blogs';
  info: {
    displayName: 'blog';
  };
  attributes: {
    heading: Attribute.String;
    subheading: Attribute.Text;
    image: Attribute.Media;
  };
}

export interface ContentContent extends Schema.Component {
  collectionName: 'components_content_contents';
  info: {
    displayName: 'content';
  };
  attributes: {
    heading: Attribute.String;
    subheading: Attribute.Text;
  };
}

export interface ContentElement extends Schema.Component {
  collectionName: 'components_content_elements';
  info: {
    displayName: 'element';
    description: '';
  };
  attributes: {
    heading: Attribute.String;
    list: Attribute.Component<'content.list', true>;
  };
}

export interface ContentHero extends Schema.Component {
  collectionName: 'components_content_heroes';
  info: {
    displayName: 'Hero';
  };
  attributes: {
    title: Attribute.String;
    subtitle: Attribute.Text;
    button: Attribute.String;
  };
}

export interface ContentList extends Schema.Component {
  collectionName: 'components_content_lists';
  info: {
    displayName: 'list';
  };
  attributes: {
    item: Attribute.String;
  };
}

export interface SharedMetaSocial extends Schema.Component {
  collectionName: 'components_shared_meta_socials';
  info: {
    displayName: 'metaSocial';
    icon: 'project-diagram';
  };
  attributes: {
    socialNetwork: Attribute.Enumeration<['Facebook', 'Twitter']> &
      Attribute.Required;
    title: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        maxLength: 60;
      }>;
    description: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        maxLength: 65;
      }>;
    image: Attribute.Media;
  };
}

export interface SharedSeo extends Schema.Component {
  collectionName: 'components_shared_seos';
  info: {
    displayName: 'seo';
    icon: 'search';
  };
  attributes: {
    metaTitle: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        maxLength: 60;
      }>;
    metaDescription: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 50;
        maxLength: 160;
      }>;
    metaImage: Attribute.Media;
    metaSocial: Attribute.Component<'shared.meta-social', true>;
    keywords: Attribute.Text;
    metaRobots: Attribute.String;
    structuredData: Attribute.JSON;
    metaViewport: Attribute.String;
    canonicalURL: Attribute.String;
  };
}

declare module '@strapi/types' {
  export module Shared {
    export interface Components {
      'card-content.card': CardContentCard;
      'contact.contact': ContactContact;
      'content.blog': ContentBlog;
      'content.content': ContentContent;
      'content.element': ContentElement;
      'content.hero': ContentHero;
      'content.list': ContentList;
      'shared.meta-social': SharedMetaSocial;
      'shared.seo': SharedSeo;
    }
  }
}
