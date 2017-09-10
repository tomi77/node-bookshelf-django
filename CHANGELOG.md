# Changelog

## master

* Add function that formats permissions in Django style (content_type.permission)
* Add function that gets list of permissions
* Add knex migrations
* Move ``bookshelf`` from `dependencies` to `peerDependencies`
* Remove ``coffee-script`` dependency
* Remove ``knex`` dependency

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
