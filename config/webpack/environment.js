const { environment } = require('@rails/webpacker')
const path = require('path')

const graphqlLoader = {
  test: /\.(graphql|gql)$/,
  exclude: /node_modules/,
  loader: 'graphql-tag/loader'
};

const handlebarsLoader = {
  test: /\.handlebars$/,
  loader: "handlebars-loader"
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
  jst: path.resolve(__dirname, '../../app/views/jst')
}}})

module.exports = environment
