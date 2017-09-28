# Changelog

## master

* Improve documentation

## 0.2.1

### News

* Add missing ``toString`` methods

### fixed

* Django.Auth.User#getPermissions for inactive user should return empty Django.Auth.Permissions collection

## 0.2.0

### News

* Add ``Django.FlatPage`` and ``Django.FlatPages``
* Add ``Django.Redirect`` and ``Django.Redirects``
* Add function that formats permissions in Django style (content_type.permission)
* Add function that gets list of permissions in ``Django.Auth.Group``, ``Django.Auth.Groups`` and ``Django.Auth.User``
* Add knex migrations
* Move ``bookshelf`` from `dependencies` to `peerDependencies`
* Remove ``coffee-script`` dependency
* Remove ``knex`` dependency

### Breaking changes

* rename model/collection names in bookshelf registry (e.g. `DjangoSession` -> `Django.Session`, `AuthUser` -> `Django.Auth.User`)
* rename model/collection names in `index.js` (e.g. `DjangoSession` -> `Session`, `AuthUser` -> `Auth.User`)

## 0.1.2

* @deps update

## 0.1.1

### fixed

* `AuthGroups` collection returned by auth_model.Collection is always undefined

## 0.1.0

### News

* `AuthGroup` model / `AuthGroups` collection
* `AuthPermission` model / `AuthPermissions` collection
* `AuthUser` model / `AuthUsers` collection
* `DjangoContentType` model / `DjangoContentTypes` collection
* `DjangoSession` model / `DjangoSessions` collection
* `DjangoSite` model / `DjangoSites` collection
