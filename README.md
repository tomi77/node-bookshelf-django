# Django models for Bookshelf

[![Build Status](https://travis-ci.org/tomi77/node-bookshelf-django.svg)](https://travis-ci.org/tomi77/node-bookshelf-django)
[![Coverage Status](https://coveralls.io/repos/github/tomi77/node-bookshelf-django/badge.svg?branch=master)](https://coveralls.io/github/tomi77/node-bookshelf-django?branch=master)
[![Code Climate](https://codeclimate.com/github/tomi77/node-bookshelf-django/badges/gpa.svg)](https://codeclimate.com/github/tomi77/node-bookshelf-django)
[![dependencies Status](https://david-dm.org/tomi77/node-bookshelf-django/status.svg)](https://david-dm.org/tomi77/node-bookshelf-django)
[![devDependencies Status](https://david-dm.org/tomi77/node-bookshelf-django/dev-status.svg)](https://david-dm.org/tomi77/node-bookshelf-django?type=dev)
[![peerDependencies Status](https://david-dm.org/tomi77/node-bookshelf-django/peer-status.svg)](https://david-dm.org/tomi77/node-bookshelf-django?type=peer)
![Downloads](https://img.shields.io/npm/dt/bookshelf-django.svg)

## Installation

~~~bash
npm install bookshelf-django --save
~~~

## Usage

Load models to ``registry``

~~~js
require('bookshelf-django')(bookshelf);

var AuthUser = bookshelf.model('Django.Auth.User');
~~~

or load model/collection

~~~js
var AuthUser = require('bookshelf-django')(bookshelf).Auth.User;
~~~

## Available models / collections

``Django.Session`` / ``Django.Sessions`` - Django session framework

``Django.Site`` / ``Django.Sites`` - Django site

``Django.ContentType``/ ``Django.ContentTypes`` - Django content type

``Django.Auth.Permission`` / ``Django.Auth.Permissions`` - Permissions

``Django.Auth.Group`` / ``Django.Auth.Groups`` - Groups of permissions

``Django.Auth.User`` / ``Django.Auth.Users`` - Django users
