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

#### `toString() -> Promise<string>`

Returns `Promise` with string representation of a permission.

~~~js
AuthPermission.forge({id: 1})
.fetch()
.then(function(permission) {
  return permission.toString()
}).then(function(permission) {
  console.log(permission)
})
~~~

Why Promise, not string? String representation needs `ContentType` object.

### Django.Auth.Permissions

Permission collection

#### `getPermissions() -> Promise<Array<string>>`

Array of a string representations of permissions.

~~~js
AuthPermissions.forge()
.fetch()
.then(function(permissions) {
  return permissions.getPermissions()
}).then(function(permissions) {
  console.log(permissions)
})
~~~

### Django.Auth.Group

Groups of permissions model

### Django.Auth.Groups

Groups of permissions collection

### Django.Auth.User

Django user collection

### Django.Auth.Users

Django user collection
