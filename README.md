# Google Authenticator Plugin

I added some dual auth to some of my own servers and wondered if it could be adapted to Redmine.

It seems it can.

Suggestions or comments welcome on Slack.

## Install
Download the plugin into the /plugins directory and make sure the name of the subdir is 'google_authenticator'
then
```rake redmine:plugins```

## Configure
Under Admin/Plugins you can set a policy. Currently these are whether:
+ users can enable the setting
+ it should be enforced
+ Administrators should be exempted

## User settings
The user can find the settings on their account page at the bottom of the prefences box.

