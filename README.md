# Django models for Bookshelf

[![Code Climate](https://codeclimate.com/github/tomi77/node-bookshelf-django/badges/gpa.svg)](https://codeclimate.com/github/tomi77/node-bookshelf-django)
[![dependencies Status](https://david-dm.org/tomi77/node-bookshelf-django/status.svg)](https://david-dm.org/tomi77/node-bookshelf-django)
[![devDependencies Status](https://david-dm.org/tomi77/node-bookshelf-django/dev-status.svg)](https://david-dm.org/tomi77/node-bookshelf-django?type=dev)
![Downloads](https://img.shields.io/npm/dt/bookshelf-django.svg)

## Installation

~~~bash
npm install bookshelf-django --save
~~~

## Usage

Load models to ``registry``

~~~js
require('bookshelf-django')(bookshelf);
~~~

or load model/collection

~~~js
var AuthUser = require('bookshelf-django')(bookshelf).AuthUser;
~~~

## Available models / collections

``DjangoSession`` / ``DjangoSessions`` - Django session framework

``DjangoSite`` / ``DjangoSites`` - Django site

``DjangoContentType``/ ``DjangoContentTypes`` - Django content type

``AuthPermission`` / ``AuthPermissions`` - Permissions

``AuthGroup`` / ``AuthGroups`` - Groups of permissions

``AuthUser`` / ``AuthUsers`` - Django users
