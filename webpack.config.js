// webpack.config.js

var path = require('path')
var webpack = require('webpack')
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const devMode = process.env.NODE_ENV !== 'production';

module.exports = {
    entry: {
        app: ['./source/javascripts/app.js', './source/stylesheets/app.css.scss']
    },
    output: {
        filename: 'source/javascripts/[name].js',
        path: path.resolve(__dirname, '.tmp/dist')
    },

    module: {
        rules: [
            {
                test: /\.(sa|sc|c)ss$/,
                resolve: {
                    extensions: ['.scss', '.sass'],
                },
                use: [
                    {
                        loader: MiniCssExtractPlugin.loader,
                        options: {
                            hot: devMode
                        },
                    },
                    'css-loader',
                    {
                        loader: 'postcss-loader',
                        options: {
                            plugins: () => [require('autoprefixer')]
                        }
                    },
                    {
                        loader: 'sass-loader',
                         options: {
                             includePaths: [
                                 'source/stylesheets',
                                 'node_modules/foundation-sites/scss'
                             ]
                         }
                    }
                ]
            }
        ]
    },
    plugins: [
        new MiniCssExtractPlugin({
            // Options similar to the same options in webpackOptions.output
            // both options are optional
            filename: devMode ? 'source/stylesheets/[name].css' : 'source/stylesheets/[name].[hash].css',
            chunkFilename: devMode ? '[id].css' : '[id].[hash].css',
        })
    ]
}
