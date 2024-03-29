# Django models for Bookshelf

[![Node.js CI](https://github.com/tomi77/node-bookshelf-django/actions/workflows/node.js.yml/badge.svg)](https://github.com/tomi77/node-bookshelf-django/actions/workflows/node.js.yml)
[![CodeQL](https://github.com/tomi77/node-bookshelf-django/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/tomi77/node-bookshelf-django/actions/workflows/codeql-analysis.yml)
![Downloads](https://img.shields.io/npm/dt/bookshelf-django.svg)

## Table of contents

* [Installation](#installation)
* [Usage](#usage)
* [Available models / collections](#available-models--collections)
  * [Django.Session](#djangosession)
  * [Django.Sessions](#djangosessions)
  * [Django.Site](#djangosite)
  * [Django.Sites](#djangosites)
  * [Django.FlatPage](#djangoflatpage)
  * [Django.FlatPages](#djangoflatpages)
  * [Django.Redirect](#djangoredirect)
  * [Django.Redirects](#djangoredirects)
  * [Django.ContentType](#djangocontenttype)
  * [Django.ContentTypes](#djangocontenttypes)
  * [Django.Auth.Permission](#djangoauthpermission)
  * [Django.Auth.Permissions](#djangoauthpermissions)
  * [Django.Auth.Group](#djangoauthgroup)
  * [Django.Auth.Groups](#djangoauthgroups)
  * [Django.Auth.User](#djangoauthuser)
  * [Django.Auth.Users](#djangoauthusers)
* [Testing your project](#testing-your-project)

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

### Django.FlatPage

Django flat page model

### `toString() -> string`

Returns string representation of a permission.

~~~js
const FlatPage = bookshelf.model('Django.FlatPage')

FlatPage.forge({id: 1})
.fetch()
.then(function(flat_page) {
  console.log(flat_page.toString())
})
~~~

### Django.FlatPages

Django flat pages collection

### Django.Redirect

Django redirect model

### `toString() -> string`

Returns string representation of a redirect.

~~~js
const Redirect = bookshelf.model('Django.Redirect')

Redirect.forge({id: 1})
.fetch()
.then(function(redirect) {
  console.log(redirect.toString())
})
~~~

### Django.Redirects

Django redirects collection

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
  console.log(permission)
})
~~~

#### `stringify(permissionModel) -> string`

_Parameters_

* ``permissionModel`` `Django.Auth.Permission`

  `Django.Auth.Permission` object

Stringify a `Django.Auth.Permission` object.

~~~js
const AuthPermission = bookshelf.model('Django.Auth.Permission')

AuthPermission.forge({id: 1})
.fetch()
.then(AuthPermission.stringify)
.then(function(permission) {
  console.log(permission)
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
const AuthPermission = bookshelf.model('Django.Auth.Permission')
const AuthUser = bookshelf.model('Django.Auth.User')

AuthUser.forge({id: 1})
.fetch()
.then(function(user) {
  return user.getPermissions()
}).then(function(permissions) {
  console.log(permissions.map(AuthPermission.stringify))
})
~~~

### Django.Auth.Users

Django user collection

## Testing your project

In `beforeAll` hook runs knex migrations in order

* Django
* Your project

All migrations must have own migration table (`tableName` property).

~~~js
before(() => {
  knex.migrate.latest({directory: 'node_modules/bookshelf-django/migrations/', tableName: 'knex_migrations_django'})
}).then(() => {
  knex.migrate.latest({directory: 'migrations/', tableName: 'knex_migrations_my_project'})
})
~~~

In `afterAll` hook runs knex migrations in reverse order

* Your project
* Django

~~~js
after(() => {
  knex.migrate.rollback({directory: 'migrations/', tableName: 'knex_migrations_my_project'})
}).then(() => {
  knex.migrate.rollback({directory: 'node_modules/bookshelf-django/migrations/', tableName: 'knex_migrations_django'})
})
~~~
