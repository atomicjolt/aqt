const { environment } = require('@rails/webpacker');
const I18nPlugin = require('../../frontend_build/i18nPlugin');

const graphqlLoader = {
  test: /\.(graphql|gql)$/,
  exclude: /node_modules/,
  loader: 'graphql-tag/loader'
};

// Insert json loader at the end of list
environment.loaders.append('graphql', graphqlLoader);

environment.plugins.append('i18n', new I18nPlugin());

// environment.resolvedModules.append('frontend_build', 'frontend_build')
environment.config.merge({
  resolveLoader: {
    modules: ['node_modules', 'frontend_build']
  }
});

module.exports = environment;
