# Django models for Bookshelf

[![Build Status](https://travis-ci.org/tomi77/node-bookshelf-django.svg)](https://travis-ci.org/tomi77/node-bookshelf-django)
[![Coverage Status](https://coveralls.io/repos/github/tomi77/node-bookshelf-django/badge.svg?branch=master)](https://coveralls.io/github/tomi77/node-bookshelf-django?branch=master)
[![Code Climate](https://codeclimate.com/github/tomi77/node-bookshelf-django/badges/gpa.svg)](https://codeclimate.com/github/tomi77/node-bookshelf-django)
[![dependencies Status](https://david-dm.org/tomi77/node-bookshelf-django/status.svg)](https://david-dm.org/tomi77/node-bookshelf-django)
[![devDependencies Status](https://david-dm.org/tomi77/node-bookshelf-django/dev-status.svg)](https://david-dm.org/tomi77/node-bookshelf-django?type=dev)
[![peerDependencies Status](https://david-dm.org/tomi77/node-bookshelf-django/peer-status.svg)](https://david-dm.org/tomi77/node-bookshelf-django?type=peer)
![Downloads](https://img.shields.io/npm/dt/bookshelf-django.svg)

## Table of contents

* [Installation](#installation)
* [Usage](#usage)
* [Available models / collections](#available-models--collections)
  * [Django.Session](#djangosession)
  * [Django.Sessions](#djangosessions)
  * [Django.Site](#djangosite)
  * [Django.Sites](#djangosites)
  * [Django.ContentType](#djangocontenttype)
  * [Django.ContentTypes](#djangocontenttypes)
  * [Django.Auth.Permission](#djangoauthpermission)
  * [Django.Auth.Permissions](#djangoauthpermissions)
  * [Django.Auth.Group](#djangoauthgroup)
  * [Django.Auth.Groups](#djangoauthgroups)
  * [Django.Auth.User](#djangoauthuser)
  * [Django.Auth.Users](#djangoauthusers)

## Installation

### NPM

~~~bash
npm install bookshelf-django --save
~~~

### Yarn

~~~bash
yarn add bookshelf-django
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

### Django.Session

Django session framework model

### Django.Sessions

Django session framework collection

### Django.Site

Django site model

### Django.Sites

Django site collection

### Django.ContentType

Django content type model

### Django.ContentTypes

Django content type collection

### Django.Auth.Permission

Permission model

#### `toString() -> string`

Returns string representation of a permission.

~~~js
const AuthPermission = bookshelf.model('Django.Auth.Permission')

AuthPermission.forge({id: 1})
.fetch({withRelated: 'contentType'})
.then(function(permission) {
  console.log(permission.toString())
})
~~~

#### `toStringAsync() -> Promise<string>`

Returns `Promise` with string representation of a permission.

~~~js
const AuthPermissions = bookshelf.collection('Django.Auth.Permissions')

AuthPermission.forge({id: 1})
.fetch({withRelated: 'contentType'})
.then(function(permission) {
  return permission.toStringAsync()
}).then(function(permission) {
  console.log('' + permission)
})
~~~

### Django.Auth.Permissions

Permission collection

### Django.Auth.Group

Groups of permissions model

#### `getPermissions() -> Promise<Django.Auth.Permissions>`

Collection of permissions of group permissions.

~~~js
const AuthPermission = bookshelf.model('Django.Auth.Permission')
const AuthGroup = bookshelf.model('Django.Auth.Group')

AuthGroup.forge()
.fetch({withRelated: ['permissions', 'permissions.contentType']})
.then(function(permissions) {
  return permissions.getPermissions()
}).then(function(permissions) {
  console.log(permissions.map(AuthPermission.stringify))
})
~~~

### Django.Auth.Groups

Groups of permissions collection

#### `getPermissions() -> Promise<Django.Auth.Permissions>`

Collection of unique permissions of group permissions.

~~~js
const AuthPermission = bookshelf.model('Django.Auth.Permission')
const AuthGroups = bookshelf.collection('Django.Auth.Groups')

AuthGroups.all()
.fetch({withRelated: ['permissions', 'permissions.contentType']})
.then(function(permissions) {
  return permissions.getPermissions()
}).then(function(permissions) {
  console.log(permissions.map(AuthPermission.stringify))
})
~~~

### Django.Auth.User

Django user collection

#### `getPermissions() -> Promise<Django.Auth.Permissions>`

Collection of unique permissions of group permissions and permissions.

~~~js
const AuthUser = bookshelf.collection('Django.Auth.User')

AuthUser.all()
.fetch()
.then(function(user) {
  return user.getPermissions()
}).then(function(permissions) {
  console.log(permissions.map(AuthPermission.stringify))
})
~~~

### Django.Auth.Users

Django user collection
