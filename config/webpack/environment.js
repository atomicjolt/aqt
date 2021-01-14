const { environment } = require('@rails/webpacker')
const path = require('path')

const graphqlLoader = {
  test: /\.(graphql|gql)$/,
  exclude: /node_modules/,
  loader: 'graphql-tag/loader'
};

const handlebarsPath = path.resolve(__dirname, '../../app/views/jst')

const handlebarsLoader = {
  test: /\.handlebars$/,
  loader: "handlebars-loader",
  options: {
    rootRelative: handlebarsPath+"/",
    partialResolver: function(partial, callback) {
      const parts = partial.split("/");
      const end = parts.length - 1;
      parts[end] = `_${parts[end]}`;
      const stringPath = parts.join("/")
      callback(null, `${handlebarsPath}/${stringPath}`);
    }
  }
}

const coffeeLoader = {
  test: /\.coffee$/,
  loader: 'coffee-loader'
}

// Insert json loader at the end of list
environment.loaders.append('graphql', graphqlLoader);
environment.loaders.append('handlebars', handlebarsLoader);
environment.loaders.append('coffeescript', coffeeLoader);

environment.config.merge({resolve: {alias: {
  Backbone: path.resolve(__dirname, '../../public/javascripts/Backbone.js'),
  jst: handlebarsPath,
  i18n: path.resolve(__dirname, '../../client/mocks/i18n.js')
}}})

module.exports = environment
