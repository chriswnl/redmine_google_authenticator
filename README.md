# Google Authenticator Plugin

Allows dual factor authentication using the Google Authenticator plugin from the Android Play store, or Apple's Apps Store.

## Install
Download the plugin into the /plugins directory and make sure the name of the subdir is 'google_authenticator'
then

```rake redmine:plugins``` and
```rake redmine:plugins:assets```

The migration adds a table, ```two_step_auths``` to your installation and sets up a has_one relationship from the users table,
thus not polluting existing tables.

## Configure
Under Admin/Plugins you can set a policy. Currently these are whether:

* users can enable the setting
* it should be enforced
* Administrators should be exempted

## User settings
The user can find the settings on their account page at the bottom of the prefences box.

## Removal
As the plugin does not pollute any existing tables you can just remove it from the plugins directory.
You should probably run ```rake redmine:plugins``` again when finished.
