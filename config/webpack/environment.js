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

// Insert json loader at the end of list
environment.loaders.append('graphql', graphqlLoader);
environment.loaders.append('handlebars', handlebarsLoader);

environment.config.merge({resolve: {alias: {
  Backbone: 'backbone',
  jst: path.resolve(__dirname, '../../app/views/jst')
}}})

module.exports = environment
